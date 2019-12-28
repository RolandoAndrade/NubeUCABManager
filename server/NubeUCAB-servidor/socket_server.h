#include "socket.h"
#include "socket_exceptions.h"

using namespace std;

class ServerSocket : private Socket
{
	public:

		ServerSocket()
		{
			if(!Socket::create())
			{
				throw SocketException(strerror(errno));
			}
		}

		ServerSocket(int port)
		{
			if(!Socket::create())
			{
				throw SocketException(strerror(errno));
			}

			if(!Socket::bind(port))
			{
				throw SocketException(strerror(errno));
			}

			if(!Socket::listen())
			{
				throw SocketException(strerror(errno));
			}
		}

		~ServerSocket()
		{
            close();
		}

		/*Mandar datos desde el socket*/

		ServerSocket& operator << (string &data)
		{
			if(Socket::send(data)==-1)
			{
				throw SocketException(strerror(errno));
			}
			return *this;
		}

		/*Recibir datos desde el socket*/

		ServerSocket& operator >> (string &data)
		{
			if(Socket::recv(data)==-1)
			{
				throw SocketException(strerror(errno));
			}

			return *this;
		}

		/*Aceptar conexión entrante*/

		void accept(ServerSocket &ssocket)
		{
			if(!Socket::accept(ssocket))
			{
				throw SocketException(strerror(errno));
			}
		}

		/*Cerrar socket*/

		void close()
		{
			if(!Socket::close())
			{
				cout<<"Errrrrrorrrr: "<<strerror(errno)<<" "<<getFD()<<endl;
				throw SocketException(strerror(errno));
			}
		}

		int getFD()
		{
			return Socket::getFD();
		}

		int getPort()
		{
			return Socket::getPort();
		}

		string getHost()
		{
			return Socket::getHost();
		}
};
