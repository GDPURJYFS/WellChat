#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Sparrow/qtnativeforandroid.h"
#include "Sparrow/notificationclient.h"
#include "Sparrow/keyboard.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //! [java register native function]
#ifdef Q_OS_ANDROID
    qDebug() << "QtNative::registerNativeMethod : "
             << QtNativeForAndroid::registerNativeMethodForJava();
#endif
    //! [java register native function]

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
    context->setContextProperty("Keyboard", Keyboard::singleton());
    //! [4]

    return app.exec();
}
