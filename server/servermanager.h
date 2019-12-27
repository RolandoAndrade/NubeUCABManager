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
    public:
        explicit ServerManager(QQmlApplicationEngine& engine, QObject *parent = nullptr);

        ServerManager()
        {

        }

    public slots:
        void startServer(int port = 3000)
        {
            FTPServer server(port);
            tServer = std::thread(&FTPServer::start,server);
            //t1.join();

        }

        void stopServer()
        {

        }

};

#endif // SERVERMANAGER_H
