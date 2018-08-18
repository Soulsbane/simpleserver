module simpleserver.client;

import std.stdio;
import std.socket;

class SimpleClient
{
	this()
	{
		client_ = new TcpSocket();
	}

	void connect(ushort port = 5899)
	{
		client_.connect(new InternetAddress(port));
	}

	void send(const string message)
	{
		client_.send(message);
	}

	void disconnect()
	{
		client_.shutdown(SocketShutdown.BOTH);
		client_.close();
	}

private:
	Socket client_;
}
