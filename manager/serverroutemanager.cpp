#include "serverroutemanager.h"


std::string ServerRouteManager::SERVER_DIRECTORY = "/home/rolandoandrade/NubeUCAB";

void ServerRouteManager::setRoute(QString route)
{
    SERVER_DIRECTORY = route.toStdString();
}

QString ServerRouteManager::getRoute()
{
    return QString(SERVER_DIRECTORY.c_str());
}

void ServerRouteManager::goToFileManager()
{

    QQmlApplicationEngine * engine = qobject_cast<QQmlApplicationEngine *>(qmlEngine(this));
    QObject *w = engine->rootObjects().first();
    QObject *x = engine->rootObjects().at(1);
    x->setProperty("visible",true);
    w->setProperty("visible",false);

}

void ServerRouteManager::goToUserManager()
{
    QQmlApplicationEngine * engine = qobject_cast<QQmlApplicationEngine *>(qmlEngine(this));
    QObject *w = engine->rootObjects().first();
    QObject *x = engine->rootObjects().at(1);
    w->setProperty("visible",true);
    x->setProperty("visible",false);

}
