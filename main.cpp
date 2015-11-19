/*!
 * Activity 先于 Qt 加载
 * 1. 在 Activity OnCreate 中调用 QtBridgingAndroid::Init，然后进入Qt::main
 * 2. 在 Qt::main 中注册 Java 的 native 函数 QtBridgingAndroid::notifiedKeyboardRectangle
 * 3. 在 Qt::main 通过调用 Java::QtBridgingAndroid::listenKeyboardHeight 注入监听键盘事件
 * 4. 在 Qt::main 加载 QML。
*/

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Sparrow/qtnativeforandroid.h"
#include "Sparrow/notificationclient.h"
#include "Sparrow/keyboard.h"

int main(int argc, char *argv[])
{
    //! [java register native function]
#ifdef Q_OS_ANDROID
    qDebug() << "QtNative::registerNativeMethod : "
             << QtNativeForAndroid::registerNativeMethodForJava();
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

    //! [1]
    //! register qml type
    //! [1]

    //! [2]
    //! import path or imoprt plugin
    engine.addImportPath("qrc:/qml/WellChat");
    //! [2]

    //! [3]
    //! load qml file
    engine.load(QUrl(QStringLiteral("qrc:/qml/WellChat/main.qml")));
    //! [3]

    //! [4]
    NotificationClient *notificationClient = new NotificationClient(&engine);
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("notificationClient", notificationClient);
    //! 调用 Java::QtBridgingAndroid::listenKeyboardHeight 注入监听键盘事件
    context->setContextProperty("Keyboard", Keyboard::singleton());
    //! [4]

    return app.exec();
}
