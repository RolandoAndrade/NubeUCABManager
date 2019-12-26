#ifndef USERMANAGERHEADER
#define USERMANAGERHEADER

#include <string>
#include <map>
#include <iostream>
#include <fstream>
#include <sys/stat.h>

using namespace std;

typedef map<string, pair<string, string>> LoginInfo;

int createDir(string directory)
{
    return !mkdir(directory.c_str(), S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
}

int appendUserToFile(string name, string password, string home)
{
    ofstream myfile;
    myfile.open ("users/users.info", ios::out | ios::app | ios::binary);
    createDir(home);
    myfile << name << " " << password << " " << home << "\n";
    myfile.close();
    return 0;
}

LoginInfo retrieveUsersFromFile()
{
    LoginInfo list;
    ifstream in("users/users.info", ios::in| ios::binary);

    if(in)
    {
        string user, pass, home;
        while (in >> user >> pass >> home)
        {
            list[user] = make_pair(pass,home);
        }
    }

    return list;
}

int updateUsersFromFile(LoginInfo data)
{
    ofstream myfile;
    myfile.open ("users/users.info", ios::out | ios::binary);
    for(auto d: data)
        myfile << d.first << " " << d.second.first << " " << d.second.second << "\n";
    myfile.close();
    return 0;
}

int dropUsersFromFile(string user)
{

    LoginInfo f = retrieveUsersFromFile();
    f.erase(user);
    return updateUsersFromFile(f);
}

#endif // USERMANAGERHEADER
