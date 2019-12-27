#ifndef SERVERWRAPPER_H
#define SERVERWRAPPER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include "NubeUCAB-servidor/FTPServer.h"


class ServerWrapper: public QObject
{
    Q_OBJECT
    //Q_PROPERTY(double best READ best WRITE setBest NOTIFY bestchanged)

    private:
        QQmlApplicationEngine engine;
    public:
        explicit ServerWrapper(QQmlApplicationEngine& engine, QObject *parent = nullptr);

        ServerWrapper()
        {

        }
        void startServer(int port)
        {

        }

        void stopServer()
        {

        }


};

#endif // SERVERWRAPPER_H
