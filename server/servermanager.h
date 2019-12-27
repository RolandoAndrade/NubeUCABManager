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
        void startServer(int p = 3000)
        {
            serverEnabled = true;
            port = p;
            FTPServer server(port,&serverEnabled);
            tServer = std::thread(&FTPServer::start,server);

        }

        void stopServer()
        {
            serverEnabled = false;
            Socket s;
            s.create();
            s.connect(lookup("127.0.0.1"),port);
            s.close();
            tServer.detach();
            tServer.~thread();
        }

};

#endif // SERVERMANAGER_H
