#ifndef USERMANAGER_H
#define USERMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include "user_manager.h"

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
        bool addUser(QString user, QString password, QString home)
        {
            return 0;
        }

        bool removeUser(QString user)
        {
            return 0;
        }

        QVariantList readUsers()
        {

            vector<string> v({"blue","green","red","yellow"});
            int i = 0;
            QVariantList users;

            return users;
        }


};

#endif // USERMANAGER_H
