#include <string>
#include <vector>
#include <sstream>
#include <cstdlib>
#include <iostream>

using namespace std;

class FTPResponse {
	private:
		string message;
		string status;

	public:
		FTPResponse()
		{

		}

		~FTPResponse()
		{
			message = "";
			status = "";
		}

		FTPResponse(string response)
		{
			setResponse(response);
		}

		FTPResponse(string code,string response)
		{
			message = response;
			status = code;
		}
		
		void setResponse(string response)
		{
			message = response;
			status = "";
		}

		string parseResponse()
		{
			string::size_type firstPos = message.find_first_not_of(" ", 0);
			if(isdigit(message[firstPos]))
			{
				string::size_type lastPos = message.find(" ",firstPos);
				status = message.substr(firstPos,lastPos-firstPos);
				firstPos = message.find_first_not_of(" ", lastPos);
			}
			return message.substr(firstPos);
		}

		string parseResponse(int &code)
		{
			string response = parseResponse();
			code = atoi(status.c_str());
			return response;
		}

		string getResponse()
		{
			return status+" "+message+"\r\n";
		}

		int returnCode()
		{
			if(status == "")
			{
				parseResponse();
			}
			return atoi(status.c_str());
		}
		
		int getPort()
		{
			string::size_type firstPos = message.find("(", 0);
			string::size_type lastPos = message.find(")",firstPos);

			string port_string = message.substr(firstPos+1,lastPos-firstPos-1);
			
			int c = 0;
			string host="";
			firstPos = 0;

			while(c<4)
			{
				firstPos = port_string.find(",", firstPos);
				if(c<3)
				{
					port_string[firstPos] = '.';
				}
				c++;
			}

			host = port_string.substr(0,firstPos);
			port_string = port_string.substr(firstPos+1);
			firstPos = port_string.find(",");

			int port = 256 * atoi(port_string.substr(0,firstPos).c_str());
			port += atoi(port_string.substr(firstPos+1).c_str());
			
			return port;
		}
};