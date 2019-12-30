#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "server/usermanager.h"
#include "server/servermanager.h"
#include "manager/filemanager.h"
#include "manager/serverroutemanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Material");
    qmlRegisterType<UserManager>("com.nubeucab.usermanager",1,0,"UserManager");
    qmlRegisterType<ServerManager>("com.nubeucab.servermanager",1,0,"ServerManager");
    qmlRegisterType<FileManager>("com.nubeucab.filemanager",1,0,"FileManager");
    qmlRegisterType<ServerRouteManager>("com.nubeucab.srmanager",1,0,"ServerRouteManager");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    engine.load(QUrl(QStringLiteral("qrc:/manager.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
