#ifndef SERVERMANAGER_H
#define SERVERMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <thread>
#include "NubeUCAB-servidor/FTPServer.h"

class ServerManager: public QObject
{
    Q_OBJECT

    private:
        QQmlApplicationEngine engine;
        std::thread tServer;
        int port;
        bool serverEnabled;

    public:
        explicit ServerManager(QQmlApplicationEngine& engine, QObject *parent = nullptr);

        ServerManager()
        {

        }
        ~ServerManager()
        {

        }

    public slots:
        void startServer(int p = 3000);

        void stopServer();

};

#endif // SERVERMANAGER_H
