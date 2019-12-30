#ifndef SERVERROUTEMANAGER_H
#define SERVERROUTEMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>

#include <string>
using namespace std;

class ServerRouteManager : public QObject
{
    Q_OBJECT

    private:
        static string SERVER_DIRECTORY;



    public:
        explicit ServerRouteManager(QQmlApplicationEngine& engine, QObject *parent = nullptr);

        ServerRouteManager(){}
    public slots:

        void setRoute(QString route);

        QString getRoute();

        void goToUserManager();

        void goToFileManager();

};

#endif // SERVERROUTEMANAGER_H
