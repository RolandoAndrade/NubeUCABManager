#ifndef EXCEPTIONS_DEFINED
#define EXCEPTIONS_DEFINED

#include <string>
#include <cerrno>

using namespace std;

class SocketException 
{
	private:
		string message;

	public:
		SocketException(string s)
		{
			message = s;
		}

		~SocketException()
		{

		}

		string getMessage()
		{
			return message;
		}
};

#endif