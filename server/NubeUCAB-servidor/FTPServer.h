#include <cstdlib>
#include <cctype>
#include <cstring>
#include <cstdio>
#include <iostream>
#include <string>
#include <map>
#include <vector>
#include <sstream>
#include <fstream>
#include <unistd.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include "socket_server.h"
#include "commands.h"
#include "FTPRequest.h"
#include "FTPResponse.h"

typedef map<string, pair<string, string> > LoginInfo;



class FTPServer
{
	private:
		int port;

		string getUser(LoginInfo &info, string &user, string args)
		{
			info = formLoginInfoList();
			user = args;
			return FTPResponse("331","Introduce la contraseña").getResponse();
		}

		string getPassword(LoginInfo info, string user, string pass, int &isLogged)
		{
			string responseMsg;
			if(info.find(user) != info.end())
			{
				if(info[user].first == pass)
				{
					cd(info[user].second);
					isLogged = 1;
					responseMsg = FTPResponse("230","Ha ingresado exitosamente.").getResponse();
				}
			}

			if(!isLogged)
			{
				responseMsg = FTPResponse("530","No se ha podido iniciar sesión").getResponse();
			}
			return responseMsg;
		}

		/*Listar archivos del directorio*/

		int ls(string args, string &response, int print = 0)
		{
			int code;
            string request = FTPRequest("ls",args).getRequest("\n");
			response = execute("ls",request,code);

            if(1)
			{
				cout<<response;
			}
			return code;
		}


		/*Eliminar archivos del directorio*/

		int rm(string args, int print = 0)
		{
			int code;
			string response = execute("rm",args,code);
			if(print)
			{
				cout<<response;
			}
			return code;
		}

		int rename(string src, string dest, int print = 0)
		{
			int code;
			string response = execute("rename",src,code,dest);
			if(print)
			{
				cout<<response;
			}
			return code;
		}

		/*Información del sistema*/

		string uname(int print = 0)
		{
			int code;
			string request = FTPRequest("uname").getRequest("\n");
			string response = execute("uname",request,code);

			if(print)
			{
				cout<<response;
			}

			return response;
		}

		/*Directorio actual*/

		string pwd(int print = 0)
		{
			int code;
			string request = FTPRequest("pwd","").getRequest("\n");
			string response = execute("pwd",request, code);

			if(print)
			{
				cout<<response;
			}

			return response;
		}

		/*Entrar en directorio*/

		int cd(string args, int print = 0)
		{
			int code;
			string response = execute("cd",args,code);

			if(print)
			{
				cout<<response;
			}
			return code;
		}

		int mkd(string args, string &response, int print = 0)
		{
			int code;
			response = execute("mkdir",args,code);

			if(print)
			{
				cout<<response;
			}

			return code;
		}

		string listDir(ServerSocket &dataSocket, string args, ServerSocket &serverSocket)
		{
			string out = "", data;
			// Conección vía socket con el cliente
			if(dataSocket.getFD() != -1 )
			{
				string response;
				if(ls(args,response))
				{
					out = FTPResponse("150","Lista de directorios").getResponse();
					serverSocket << out;
					// Enviar lista al cliente
					try
					{
						int pos = 0,len=response.size();
						string buffer;
						ServerSocket ax;
						dataSocket.accept(ax);
						while(pos<len)
						{
							data = response.substr(pos,min(2048,len-pos));
							ax << data;
							pos = pos + min(2048,len-pos);
						}
						out = FTPResponse("226", "Directorio enviado").getResponse();
						serverSocket << out;
					} 
					catch(SocketException &e)
					{
						cout<<"Error: "<<e.getMessage()<<endl;
						out = FTPResponse("450", "Directorio no enviado").getResponse();
						serverSocket << out;
					}
				}
				else
				{
					out = FTPResponse("501","Error en los parámetros").getResponse();
					serverSocket << out;
				}

				dataSocket.close();
			}
			else 
			{
				out = FTPResponse("425","El servidor debe estar en PASV").getResponse();
				serverSocket << out;
			}
			return out;
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


	public:
        bool *ftpServerEnabled;

        FTPServer(int pport, bool *enabled)
		{
			cout<<"NubeUCAB-servidor ha iniciado"<<endl;
			port = pport;
            ftpServerEnabled = enabled;
		}
		~FTPServer()
        {
		}

        void start()
		{
			cout<<"El servidor está corriendo en el puerto: "<<port<<endl;

			try
			{
				//Crea un socket a la escucha de los clientes
				ServerSocket server(port);
				ServerSocket *serverSocket = new ServerSocket();
				//Espera peticiones
                while(*ftpServerEnabled)
				{
					try
					{
						server.accept(*serverSocket);
						//Se debería crear un proceso hijo, de lo contrario cierra el socket
						if(!fork())
						{
							server.close();
							communicate(serverSocket);
							(*serverSocket).close();
							exit(0);
						}
						(*serverSocket).close();
					} 
					catch(SocketException &e)
					{
						cout<<"Ha ocurrido un error al aceptar peticiones: "<<e.getMessage()<<endl;
						continue;
					}
				}
			} 
			catch(SocketException &e)
			{
				cout<<"Ha ocurrido un error al iniciar servidor: "<<e.getMessage()<<endl;
				return;
			}
            cout<<"El servidor se ha detenido"<<endl;
		}

		void help()
		{
			
		}

		void communicate(ServerSocket * serverSocket)
		{
			string data="",responseMsg="",cmd,args,user;
			ServerSocket *dataSocket;
			LoginInfo list;
			int isLogged = 0;
			int isBinaryMode = 0;
			// El servidor saluda
			try
			{
				responseMsg = FTPResponse("200","NubeUCAB dice hola").getResponse();
				*serverSocket << responseMsg;
			} 
			catch(SocketException &e)
			{
				std::cout<<"Hubo un erro: "<<e.getMessage()<<std::endl;
				return ; 
			}
			// a la escucha
            while(*ftpServerEnabled)
			{
				args.clear();
				cmd.clear();
				try
				{
					//Recibir datos del cliente
					*serverSocket >> data;
					if(parseCommand(data,cmd,args))
					{
						cout<<"Comando recibido: "<<cmd<<std::endl;
						// Obtener usuario
						if(cmd=="USER"&&args.size())
						{
							responseMsg = getUser(list, user,args);
							*serverSocket << responseMsg;
						}
						else if(cmd=="PASS" && args.length())
						{
							responseMsg = getPassword(list, user,args, isLogged);
							*serverSocket << responseMsg;
						}
						else if(cmd=="SYST" && !args.size())
						{
							responseMsg = FTPResponse("215",uname()).getResponse();
							*serverSocket << responseMsg;
						}
						else if(cmd=="PWD"  && !args.size() && isLogged)
						{
							responseMsg = FTPResponse("257",pwd()).getResponse();
							*serverSocket << responseMsg;
						}
						else if(cmd=="MKD" && args.size() && isLogged)
						{
							string response;
							if(mkd(args,response))
							{
								responseMsg = FTPResponse("257",response).getResponse();
							}
							else
							{
								responseMsg = FTPResponse("550",response).getResponse();
							}
							*serverSocket << responseMsg;
						}
						else if(cmd=="LIST" && isLogged)
						{
							responseMsg = listDir(*dataSocket,args,*serverSocket);
						}
						else if(cmd=="CWD" && args.size() && isLogged)
						{
							if(cd(args))
							{
								responseMsg = FTPResponse("250","Cambiado directorio").getResponse();
							}
							else{
								responseMsg = FTPResponse("550","No se ha podido acceder al directorio").getResponse();
							}
							*serverSocket << responseMsg;
						}
						else if(cmd=="TYPE"  && args.size() && isLogged)
						{
							if(args == "B")
							{
								isBinaryMode = 1;
								responseMsg = FTPResponse("200","Cambiado a modo binario").getResponse();
							}
							else if (args == "A")
							{
								isBinaryMode = 0;
								responseMsg = FTPResponse("200","Cambiado a modo ASCII").getResponse();
							}
							else
							{
								responseMsg = FTPResponse("400","No es un tipo correcto").getResponse();
							}

							*serverSocket << responseMsg;
						}
						else if(cmd=="PASV" && !args.size() && isLogged)
						{
							try
							{
								dataSocket =  new ServerSocket(0);
								string host =  (*serverSocket).getHost();
								replace(host.begin(), host.end(), '.', ',');
								stringstream port;
								port << (*dataSocket).getPort()/256 <<"," << (*dataSocket).getPort()%256;
								responseMsg = FTPResponse("227","Entrando en modo pasivo ("+host+","+port.str()+").").getResponse();
							}
							catch(SocketException &e)
							{
								cout<<"Ha ocurrido un error: "<<e.getMessage()<<endl;
								responseMsg = FTPResponse("425","No se puede establecer conexión").getResponse();
							}

							*serverSocket << responseMsg;
						}
						else if(cmd=="STOR" && args.size() && isLogged)
						{
							
							if(isBinaryMode)
							{
								if((*dataSocket).getFD() != -1 )
								{
									ofstream out(args.c_str(), ios::out|ios::binary);
									
									if(out)
									{
										string buff;
										ServerSocket ax;
										responseMsg = FTPResponse("150", "Ok").getResponse();
										*serverSocket<<responseMsg;
										(*dataSocket).accept(ax);

										while(1)
										{
											try
											{
												buff = "";
												ax >> buff;
												if(buff.length()==0)
												{
													break;
												}
											}
											catch (SocketException &e)
											{
												cout<<"Error : "<<e.getMessage()<<endl;
												break;
											}
											out << buff;																					
										}
									
										out.close();
										ax.close();
										(*dataSocket).close();
										responseMsg = FTPResponse("226", "Transferencia completa").getResponse();
									}
									else
									{
										responseMsg = FTPResponse("550","No se pudo realizar la transferencia").getResponse();
									}
								}
								else 
								{
									responseMsg = FTPResponse("425","Debe estar en modo PASV").getResponse();
								}

							}
							else
							{
								responseMsg = FTPResponse("550","Cambia a modo binario primero").getResponse();
							}

							*serverSocket << responseMsg;
						}
						else if(cmd=="RETR" && args.size() && isLogged)
						{
							string data;
							ServerSocket temp_socket;
							stringstream res_stream;

							if(isBinaryMode)
							{
								if((*dataSocket).getFD() != -1 )
								{
									ifstream in(args.c_str(), ios::in | ios::binary | ios::ate);

									if(in)
									{
										long length = in.tellg();
										in.seekg (0, in.beg);
										res_stream << "Conexión de datos binaria "<<args[0]<<" ("<<length<<" bytes).";
										responseMsg = FTPResponse("150",res_stream.str()).getResponse();
										*serverSocket<<responseMsg;
										(*dataSocket).accept(temp_socket);
										while (length>0)
										{
											int read_sz = Socket::MAXRECV<length ? Socket::MAXRECV : length;
											char buf[Socket::MAXRECV+1];
											in.read(buf,read_sz);
											data.assign(buf,read_sz);
											temp_socket<<data;
											length -= read_sz;
										}
										in.close();
										temp_socket.close();
										(*dataSocket).close();
										responseMsg = FTPResponse("226", "Transferencia completa").getResponse();
									}
									else
									{
										responseMsg = FTPResponse("550","No se puede recibir el archivo").getResponse();
									}
								}
								else 
								{
									responseMsg = FTPResponse("425","Debe estar en modo PASV").getResponse();
								}

							}
							else
							{
								responseMsg = FTPResponse("550","Cambie a modo binario").getResponse();
							}

							*serverSocket << responseMsg;
						}
						else if(cmd=="QUIT"  && !args.size())
						{
							try
							{
								responseMsg = FTPResponse("221","Goodbye.").getResponse();
								*serverSocket << responseMsg;
								return ;
							}
							catch(SocketException &e)
							{
								cout<<"Error: "<<e.getMessage()<<endl;
								responseMsg = FTPResponse("500","No se pudo cerrar la conexión").getResponse();
								*serverSocket << responseMsg;
							}
						}
						else if(cmd=="RENM" && args.size())
						{
							vector<string> arg,fla;
							parseCommand(data,cmd,fla,arg);
							if(rename(arg[0],arg[1]))
							{
								responseMsg = FTPResponse("250","Renombrado").getResponse();
							}
							else
							{
								responseMsg = FTPResponse("550","No se ha podido renombrar el directorio").getResponse();
							}
							*serverSocket << responseMsg;
						}
						else if(cmd=="REMV" && args.size())
						{
							if(rm(args))
							{
								responseMsg = FTPResponse("250","Eliminado").getResponse();
							}
							else
							{
								responseMsg = FTPResponse("550","No se ha podido eliminar el directorio").getResponse();
							}
							*serverSocket << responseMsg;
						}
						else if(!isLogged)
						{
							responseMsg = FTPResponse("332","Necesitas iniciar sesión").getResponse();
							*serverSocket << responseMsg;
						} 
						else
						{
							responseMsg = FTPResponse("500","Comando desconocido").getResponse();
							*serverSocket << responseMsg;
						}
					}
					else
					{
						responseMsg = FTPResponse("500","Comando desconocido").getResponse();
						*serverSocket << responseMsg;
					}
				} 
				catch(SocketException &e)
				{
					cout<<"Ha ocurrido un error : "<<e.getMessage()<<endl;
					return ;
				}
			}
		}
};
