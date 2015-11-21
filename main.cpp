/*!
 * Activity 先于 Qt 加载
 * 1. 在 Activity OnCreate 中调用 QtBridgingAndroid::Init，然后进入Qt::main
 * 2. 在 Qt::main 中注册 Java 的 native 函数 QtBridgingAndroid::notifiedKeyboardRectangle
 * 3. 在 Qt::main 通过调用 Java::QtBridgingAndroid::listenKeyboardHeight 注入监听键盘事件
 * 4. 在 Qt::main 加载 QML。
*/

#include <QApplication>
#include <QQmlApplicationEngine>
#include <qqml.h>
#include <QQmlContext>
#include "Sparrow/qtbridgingandroid.h"
#include "Sparrow/keyboard.h"

#include "src/wellchat/collectionsmodel.h"

int main(int argc, char *argv[])
{
    //! [java register native function]
#ifdef Q_OS_ANDROID
    qDebug() << "QtNative::registerNativeMethod : "
             << QtBridgingAndroid::registerNativeMethodForJava();
#endif
    //! [java register native function]

    QApplication app(argc, argv);


    //! [0]
    app.setApplicationName("WellChat");
    app.setOrganizationDomain("github.com/GDPURJYFS");
    app.setOrganizationName("GDPURJYFS");
    app.setApplicationVersion("0.0.1");
    //! [0]

    QQmlApplicationEngine engine;

#ifdef Q_OS_ANDROID
    //! [1] 向java安装事件监听，需要在 QApplication 示例化之后
    QtBridgingAndroid::installListener();
    // QQmlEngine: Illegal attempt to connect to Keyboard(0xe20036a0)
    // that is in a different thread than the QML engine
    // QQmlApplicationEngine(0xe0fa1924.
    //! [1]
#endif

    //! [2]  register qml type

    qmlRegisterType<CollectionsModel>("WellChat", 1, 0, "CollectionsModel");

    //! [2]

    //! [3]
    //! import path or imoprt plugin
    engine.addImportPath("qrc:/qml/WellChat");
    //! [3]

    //! [4]
    //! load qml file
    engine.load(QUrl(QStringLiteral("qrc:/qml/WellChat/main.qml")));
    //! [4]

    //! [5]
    QtBridgingAndroid *BridgingAndroid = new QtBridgingAndroid(&engine);

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("BridgingAndroid", BridgingAndroid);
    //! 调用 Java::QtBridgingAndroid::listenKeyboardHeight 注入监听键盘事件
    context->setContextProperty("Keyboard", Keyboard::singleton());
    //! [5]

    return app.exec();
}
