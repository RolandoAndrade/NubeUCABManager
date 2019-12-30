#include "serverroutemanager.h"

string ServerRouteManager::SERVER_DIRECTORY = "/home/rolandoandrade/NubeUCAB";

ServerRouteManager::ServerRouteManager(QObject *parent) : QObject(parent)
{

}

void ServerRouteManager::setRoute(QString route)
{
    SERVER_DIRECTORY = route.toStdString();
}

string ServerRouteManager::getRoute()
{
    return QString(SERVER_DIRECTORY.c_str());
}
