#ifndef COMMANDS
#define COMMANDS

#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <cctype>
#include <iostream>
#include <iomanip>
#include <string>
#include <sstream>
#include <fstream>
#include <algorithm>
#include <vector>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include "socket_exceptions.h"

using namespace std;
int lookup(string h);
int isANumber(string s);
void renameFile(stringstream &data, int &code, string file, string directory);
void rm(stringstream &data, int &code, string file);
string getPassword();
string getFileName(string s);
string getFilePath(string s);
void pwd(stringstream &data, int &code);
void cd(stringstream &data, int &code, string directory);
void mkdirectory(stringstream &data, int &code, string directory);
void ls(FILE *in, int &code);
string execute(string command, string directory, int &code, string directory2="");
vector<string> tokenize(string s, string sep);
string replaceAllOccurences(string s, string search, string replace);
int parseCommand(string command,string& cmd,vector<string>& flags, vector<string>& args);
int parseCommand(string command,string& cmd, string& args);
void copyFile(string src, string dest);

#endif
