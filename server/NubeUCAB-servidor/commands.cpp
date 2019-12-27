#include "commands.h"

/*Revisar si el host existe*/
int lookup(string h)
{
    const char *host = h.c_str();
    struct sockaddr_in inaddr;
    struct hostent *hostp;

    if ((host == NULL) || (*host == '\0'))
    {
        return(INADDR_ANY);
    }

    memset ((char * ) &inaddr, 0, sizeof inaddr);

    if ((int)(inaddr.sin_addr.s_addr = inet_addr(host)) == -1)
    {
        hostp = gethostbyname(host);
        if (hostp == NULL)
        {
            throw SocketException(strerror(errno));
        }
        if (hostp->h_addrtype != AF_INET)
        {
            errno = EPROTOTYPE;
            throw SocketException(strerror(errno));
        }
        memcpy((char * ) &inaddr.sin_addr, (char * ) hostp->h_addr, sizeof(inaddr.sin_addr));
    }
    return(inaddr.sin_addr.s_addr);
}

int isANumber(string s)
{
    for(char c: s)
    {
        if(!isdigit(c))
        {
            return 0;
        }
    }
    return 1;
}

void renameFile(stringstream &data, int &code, string file, string directory)
{
    if(!rename(file.c_str(), directory.c_str()))
    {
        code = 1;
        data<<"Se ha cambiado el archivo: "<<directory<<endl;
    }
    else
    {
        data<<"Ha ocurrido un error: "<<strerror(errno)<<endl;
    }
}

void rm(stringstream &data, int &code, string file)
{
    if(!remove(file.c_str()))
    {
        code = 1;
        data<<"Se ha eliminado el archivo: "<<file<<endl;
    }
    else
    {
        data<<"Ha ocurrido un error: "<<strerror(errno)<<endl;
    }
}

/*Obtener contraseña en consola linux*/
string getPassword()
{
    termios oldt;
    tcgetattr(STDIN_FILENO, &oldt);
    termios newt = oldt;
    newt.c_lflag &= ~ECHO;
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);
    string pass;
    getline(cin, pass);
    getline(cin, pass);
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    cout<<endl;
    return pass;
}

/*Obtener nombre del archivo*/

string getFileName(string s)
{
    string::size_type pos = s.find_last_of("/\\");
    return s.substr(pos+1);
}

string getFilePath(string s)
{
    string::size_type pos = s.find_last_of("/\\");
    if(pos==string::npos)
    {
        return "";
    }
    return s.substr(0,pos);
}

void pwd(stringstream &data, int &code)
{
    char buff[2048];
    if (getcwd(buff, sizeof(buff)) != NULL)
    {
        code = 1;
        data<<"\""<<buff<<"\""<<endl;
    }
    else
    {
        data<<"\"Ha ocurrido un error: "<<strerror(errno)<<"\""<<endl;
    }
}

void cd(stringstream &data, int &code, string directory)
{
    if(chdir(directory.c_str()) == 0)
    {
        code = 1;
        data<<"Se ha cambiado de directorio: "<<directory<<endl;
    }
    else
    {
        data<<"Ha ocurrido un error: "<<strerror(errno)<<endl;
    }
}

void mkdirectory(stringstream &data, int &code, string directory)
{
    if(!mkdir(directory.c_str(), S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH))
    {
        code = 1;
        data<<"Creado directorio: \""<<directory<<"\""<<endl;
    }
    else
    {
        data<<"Error: "<<strerror(errno)<<endl;
    }
}

void ls(FILE *in, int &code)
{
    char *line;
    size_t len = 0;
    getline(&line, &len,in);
    if(string(line).find("total")==string::npos)
    {
        code = 0;
    }
}

string execute(string command, string directory, int &code, string directory2)
{
    stringstream data;
    code = 0;

    if(command == "pwd")
    {
        pwd(data, code);
    }
    else if(command == "cd")
    {
        cd(data, code, directory);
    }
    else if(command == "mkdir")
    {
        mkdirectory(data,code,directory);
    }
    else if(command == "rm")
    {
        rm(data, code, directory);
    }
    else if(command=="rename")
    {
        renameFile(data,code, directory, directory2);
    }
    else
    {
        FILE *in;
        if(!(in = popen(directory.c_str(), "r")))
        {
            data<<"No se puede realizar la operación: "<<directory<<endl;
        }
        else
        {
            code = 1;
            if(command=="ls")
            {
                ls(in,code);
            }
            char buff[2048];
            while(fgets(buff,sizeof(buff), in)!=NULL)
            {
                data<<buff;
            }
            pclose(in);
        }
    }

    return data.str();
}

vector<string> tokenize(string s, string sep)
{
    string::size_type lastPos = s.find_first_not_of(sep, 0);
    string::size_type pos = s.find_first_of(sep, lastPos);
    vector<string> tokens;
    while(pos != string::npos || lastPos != string::npos)
    {
        tokens.push_back(s.substr(lastPos,(pos - lastPos)));
        lastPos = s.find_first_not_of(sep, pos);
        pos = s.find_first_of(sep, lastPos);
    }
    return tokens;
}

string replaceAllOccurences(string s, string search, string replace)
{
    string::size_type pos = 0;
    while ((pos = s.find(search, pos)) != string::npos)
    {
        s.replace(pos, search.length(), replace);
        pos += replace.length();
    }
    return s;
}

int parseCommand(string command,string& cmd,vector<string>& flags, vector<string>& args)
{
    string::size_type beginPos = command.find_first_not_of(" \r\n", 0);
    string::size_type endPos = command.find_first_of(" \r\n",beginPos);
    cmd = command.substr(beginPos,endPos-beginPos);
    beginPos = endPos ;
    while(beginPos < command.length())
    {
        beginPos = command.find_first_not_of(" \r\n",endPos) ;
        if(beginPos != string::npos)
        {
            if(command[beginPos]=='\"')
            {
                endPos = command.find_first_of('\"',beginPos+1) ;
                if(endPos == string::npos)
                {
                    cout << "Error : Missing \" at the end." << command.substr(beginPos) << endl ;
                    return 0;
                }
                args.push_back(command.substr(beginPos+1,endPos-beginPos-1)) ;
                endPos = endPos + 1 ;
            }
            else if(command[beginPos]=='-')
            {
                endPos = command.find_first_of(" \r\n",beginPos) ;
                if(endPos == string::npos)
                {
                    endPos = command.length() ;
                }
                flags.push_back(command.substr(beginPos,endPos-beginPos)) ;
            }
            else
            {
                endPos = command.find_first_of(" \r\n",beginPos) ;
                while(command[endPos-1] == '\\' && string::npos != endPos)
                {
                    endPos = command.find_first_of(" \r\n",endPos+1) ;
                }
                if(endPos == string::npos)
                {
                    endPos = command.length() ;
                }
                args.push_back(command.substr(beginPos,endPos-beginPos)) ;
            }
        }
    }
    return 1;
}

int parseCommand(string command,string& cmd, string& args)
{
    string::size_type beginPos = command.find_first_not_of(" \r\n", 0);
    string::size_type endPos = command.find_first_of(" \r\n",beginPos);
    cmd = command.substr(beginPos,endPos-beginPos);
    beginPos = command.find_first_not_of(" \r\n",endPos);
    if(beginPos!=string::npos)
    {
        endPos = command.find_first_of("\r\n",beginPos);
        if(endPos==string::npos)
        {
            return 0;
        }
        args = command.substr(beginPos,endPos-beginPos);
    }
    return 1;
}
