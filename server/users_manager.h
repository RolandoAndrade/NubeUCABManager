#include <string>
#include <map>
#include <iostream>
#include <fstream>
#include <iostream>
using namespace std;

typedef map<string, pair<string, string>> LoginInfo;


int write(string name, string password, string home)
{
	ofstream myfile;
	myfile.open ("users/users.info", ios::out | ios::app | ios::binary); 
	myfile << name << " " << password << " " << home << "\n";
	myfile.close();
	return 0;
}

LoginInfo formLoginInfoList()
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

int rewrite(LoginInfo data)
{
	ofstream myfile;
	myfile.open ("users/users.info", ios::out | ios::binary); 
	for(auto d: data)
		myfile << d.first << " " << d.second.first << " " << d.second.second << "\n";
	myfile.close();
	return 0;
}

int removeUser(string user)
{

	LoginInfo f = formLoginInfoList();
		cout<<f.size()<<endl;
	f.erase(user);
		cout<<f.size()<<endl;
	return rewrite(f);
}