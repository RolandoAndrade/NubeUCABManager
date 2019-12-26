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
        bool addUser(QString user, QString password, QString home)
        {
            return addUserToFile(user.toStdString(), password.toStdString(), home.toStdString()+"/"+user.toStdString());
        }

        bool removeUser(QString user)
        {
            return removeUsersFromFile(user.toStdString());
        }

        QVariantList readUsers()
        {

            vector<string> v({"blue","green","red","yellow"});
            int i = 0;
            LoginInfo l = getUsersFromFile();
            QVariantList users;

            for(auto a: l)
            {
                QVariantMap data;
                data.insert("thename", a.first.c_str());
                data.insert("thepass", a.second.first.c_str());
                data.insert("theroute", a.second.second.c_str());
                data.insert("thecolor", (v[i++%v.size()]).c_str());
                users.append(data);
            }
            return users;
        }


};

#endif // USERMANAGER_H
