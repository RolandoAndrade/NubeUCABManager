#ifndef SERVERMANAGER_H
#define SERVERMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QThread>
#include "NubeUCAB-servidor/FTPServer.h"

class ServerManager: public QObject
{
    Q_OBJECT

    private:
        QQmlApplicationEngine engine;

    public:
        explicit ServerManager(QQmlApplicationEngine& engine, QObject *parent = nullptr);

        ServerManager()
        {

        }
    public slots:

        void startServer(int port = 3000)
        {
            QThread* thread = new QThread;
            this->moveToThread(thread);
            FTPServer server(port);
            server.start();
        }

        void stopServer()
        {

        }
};

#endif // SERVERMANAGER_H
