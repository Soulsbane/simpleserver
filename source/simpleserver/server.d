module simpleserver.server;

import std.stdio;
import std.socket;
import std.conv;
import std.array;

class SimpleServer
{
	this()
	{
		server_ = new TcpSocket();

		server_.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, true);
		server_.bind(new InternetAddress(port_));
		server_.listen(1);
	}

	void start()
	{
		isRunning_ = true;

		while(isRunning_)
		{
			Socket client = server_.accept();
			char[BUFFER_SIZE] buffer;
			auto received = client.receive(buffer);
			string msg = to!string(buffer[0..received]);

			onCommand(msg.split);

			client.shutdown(SocketShutdown.BOTH);
			client.close();

			if(msg == "quit")
			{
				stop();
			}
		}
	}

	void stop()
	{
		isRunning_ = false;
	}

	abstract void onCommand(const string[] commands);
	// Add command in the form of
	// Command ex quit.
	// Command subcommand.
	// Command subcommand value. ex add location /home

	private:
		ushort port_ = 5899;
		immutable ushort BUFFER_SIZE = 1024;
		Socket server_;
		bool isRunning_;
}
