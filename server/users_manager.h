#ifndef USER_MANAGER_H
#define USER_MANAGER_H

#include <string>
#include <map>
#include <iostream>
#include <fstream>
#include <sys/stat.h>

using namespace std;

typedef map<string, pair<string, string>> LoginInfo;

int createDirectory(string directory);

int addUserToFile(string name, string password, string home);


LoginInfo getUsersFromFile();


int updateUsersOfFile(LoginInfo data);


int removeUsersFromFile(string user);



#endif// USER_MANAGER_H
