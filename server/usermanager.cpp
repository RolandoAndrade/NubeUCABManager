#include "usermanager.h"

bool UserManager::addUser(QString user, QString password, QString home)
{
    return addUserToFile(user.toStdString(), password.toStdString(), home.toStdString()+"/"+user.toStdString());
}

bool UserManager::removeUser(QString user)
{
    return removeUsersFromFile(user.toStdString());
}

QVariantList UserManager::readUsers()
{
    createDirectory("users");
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
