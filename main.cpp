#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //! [0]
    app.setApplicationName("WellChat");
    app.setOrganizationDomain("github.com/GDPURJYFS");
    app.setOrganizationName("GDPURJYFS");
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
    //! get the engine rootObjects or rootContent
    //! [4]

    return app.exec();
}
