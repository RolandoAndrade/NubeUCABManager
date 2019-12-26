#ifndef USER_MANAGER_H
#define USER_MANAGER_H

#include <string>
#include <map>
#include <iostream>
#include <fstream>
#include <sys/stat.h>

using namespace std;

typedef map<string, pair<string, string>> LoginInfo;

int createDirectory(string directory)
{
    return !mkdir(directory.c_str(), S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
}

int addUserToFile(string name, string password, string home)
{
	ofstream myfile;
    myfile.open ("users/users.info", ios::out | ios::app | ios::binary);
    createDirectory(home);
	myfile << name << " " << password << " " << home << "\n";
	myfile.close();
	return 0;
}

LoginInfo getUsersFromFile()
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

int updateUsersOfFile(LoginInfo data)
{
	ofstream myfile;
	myfile.open ("users/users.info", ios::out | ios::binary); 
	for(auto d: data)
        myfile << d.first << " " << d.second.first << " " << d.second.second << "\n";
	myfile.close();
	return 0;
}

int removeUsersFromFile(string user)
{

    LoginInfo f = getUsersFromFile();
    f.erase(user);
    return updateUsersOfFile(f);
}



#endif// USER_MANAGER_H
