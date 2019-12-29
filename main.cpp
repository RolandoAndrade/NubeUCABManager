#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "server/usermanager.h"
#include "server/servermanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Material");
    qmlRegisterType<UserManager>("com.nubeucab.usermanager",1,0,"UserManager");
    qmlRegisterType<ServerManager>("com.nubeucab.servermanager",1,0,"ServerManager");

    engine.load(QUrl(QStringLiteral("qrc:/manager.qml")));


    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
