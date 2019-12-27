#include <iostream>
#include <cstdio>
#include <cstring>
#include <string>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <unistd.h>

using namespace std;

class Socket
{
	private:
		/*File descriptor del socket*/
		int sockfd;

		/*Dirección del socket*/
		struct sockaddr_in maddress;

	public:

		/*Longitud del nombre del host*/
		static const int MAXHOSTNAME = 200;

		/*Puerto de datos*/
		static const int BACKLOG = 20;

		/*Número de conexiones permitidas*/
		static const int MAXCONNECTIONS = 10;

		/*Longitud máxima de datos que se puede recibir*/
		static const int MAXRECV = 2048;

		Socket()
		{
			memset(&maddress, 0, sizeof maddress);
			sockfd = -1;
		}

		~Socket()
		{
			if(is_valid())
			{
				close();
			}
		}

		int is_valid()
		{ 
			return sockfd != -1; 
		}

		int create()
		{
			sockfd = socket(PF_INET, SOCK_STREAM, 0);

			if(!is_valid()) 
			{
				return 0;
			}
			int accept = 1;

			return setsockopt(sockfd,SOL_SOCKET,SO_REUSEADDR,&accept,sizeof(int)) != -1;
		}

		/*Servidor: Enlazar a puerto*/
		int bind(int port)
		{
			if(!is_valid())
			{
				return 0;
			}

			maddress.sin_family = AF_INET;
			maddress.sin_port = htons(port);
			memset(maddress.sin_zero, '\0', sizeof maddress.sin_zero);

			return ::bind(sockfd, (struct sockaddr *)&maddress, sizeof(maddress)) != -1;
		}

		/*Servidor: Escuchar conexiones entrantes*/
		int listen()
		{
			if (!is_valid())
			{
				return 0;
			}
			return ::listen(sockfd, BACKLOG) != -1;
		}

		/*Servidor: Aceptar conexión*/
		int accept(Socket& child)
		{
			if (!is_valid())
			{
				return 0;
			}
			int maddresslen = sizeof(maddress);
			int fd = ::accept(sockfd, (struct sockaddr *)&maddress,(socklen_t *) &maddresslen);

			if(fd == -1)
			{
				return 0;
			}
			child.setFD(fd);
			return 1;
		}

		/*Cliente: Conecta al servicio del host en el puerto*/
		int connect(int host,int port)
		{
			if(!is_valid())
			{
				return 0;
			}

			maddress.sin_family = AF_INET;
			maddress.sin_port = htons(port);
			maddress.sin_addr.s_addr = host;

			return ::connect(sockfd, (sockaddr *)&maddress, sizeof(maddress)) != -1;
		}

		/*Envía una cadena de caracteres*/
		int send(string msg)
		{
			if(!is_valid())
			{
				return -1;
			}
			return ::send(sockfd, msg.c_str(), msg.length(), 0);
		}

		/*Recibir una cadena de caracteres y retorna la longitud de la cadena*/
		int recv(string& buf)
		{
			if(!is_valid())
			{
				return -1;
			}
			char buffer[MAXRECV+5];
			int status = ::recv(sockfd, buffer, MAXRECV, 0);
			if(status > 0)
			{
				buf.assign(buffer,status);
			}

			return status;
		}

		/*Cerrar conexión*/
		int close()
		{
			if(!is_valid())
			{
				return 1;
			}
			return ::close(sockfd) != -1;
		}

		int getPort()
		{
			struct sockaddr_in local_address;
			socklen_t address_length = sizeof(local_address);
			getsockname(sockfd, (struct sockaddr*)&local_address, &address_length);
			return ntohs(local_address.sin_port);
		}

		string getHost()
		{
			struct sockaddr_in local_address;
			socklen_t address_length = sizeof(local_address);
			getsockname(sockfd, (struct sockaddr*)&local_address, &address_length);
			return string(inet_ntoa( local_address.sin_addr));
		}

		int getFD()
		{ 
			return sockfd;
		}

		int setFD(int fd)
		{
			if(fd==-1)
			{
				return 0;
			}
			sockfd = fd;


			return 1;
		}
};