#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "server/usermanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Material");
    qmlRegisterType<UserManager>("com.nubeucab.usermanager",1,0,"UserManager");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
