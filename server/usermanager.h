#ifndef USERMANAGER_H
#define USERMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include "users_manager.h"

class UserManager: public QObject
{
    Q_OBJECT
    //Q_PROPERTY(double best READ best WRITE setBest NOTIFY bestchanged)

    private:
        QQmlApplicationEngine engine;
    public:
        explicit UserManager(QQmlApplicationEngine& engine, QObject *parent = nullptr);

        UserManager()
        {

        }
    public slots:

        bool addUser(QString user, QString password, QString home);

        bool removeUser(QString user);

        QVariantList readUsers();
};

#endif // USERMANAGER_H
