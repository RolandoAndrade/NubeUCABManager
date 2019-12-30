#include "servermanager.h"

void ServerManager::startServer(int p)
{
    serverEnabled = true;
    port = p;
    FTPServer server(port,&serverEnabled);
    tServer = std::thread(&FTPServer::start,server);

}

void ServerManager::stopServer()
{
    serverEnabled = false;
    Socket s;
    s.create();
    s.connect(lookup("127.0.0.1"),port);
    s.close();
    tServer.detach();
    tServer.~thread();
}

QString ServerManager::getIP()
{
    return QString(::getIP().c_str());
}
