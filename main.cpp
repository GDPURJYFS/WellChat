#include <QApplication>
#include <QQmlApplicationEngine>
#include <QFont>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // 在c++代码这边设置全局的字体


    //QFont f("微软雅黑");
    //app.setFont(f);

    app.setApplicationName("WellChat");
    app.setOrganizationDomain("github.com/GDPURJYFS");
    app.setOrganizationName("GDPURJYFS");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/WellChat/main.qml")));

    return app.exec();
}
