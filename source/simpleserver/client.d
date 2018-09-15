module simpleserver.client;

import std.stdio;
import std.socket;
import std.conv;

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

	void send(const string message, bool waitForReceive = true)
	{
		client_.send(message);

		if(waitForReceive)
		{
			receive();
		}
	}

	void receive()
	{
		char[BUFFER_SIZE] buffer;
		auto received = client_.receive(buffer);
		string msg = to!string(buffer[0..received]);

		onMessage(msg);
	}

	void disconnect()
	{
		client_.shutdown(SocketShutdown.BOTH);
		client_.close();
	}

	abstract void onMessage(const string msg);

private:
	TcpSocket client_;
	immutable ushort BUFFER_SIZE = 1024;
}
