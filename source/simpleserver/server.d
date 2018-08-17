module simpleserver.server;

import std.stdio;
import std.socket;
import std.conv;
import std.array;

class SimpleServer
{
	this()
	{
		server = new TcpSocket();

		server.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, true);
		server.bind(new InternetAddress(port_));
		server.listen(1);
	}

	void start()
	{
		isRunning = true;

		while(isRunning)
		{
			Socket client = server.accept();
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
		isRunning = false;
	}

	abstract void onCommand(string[] commands);
	// Add command in the form of
	// Command ex quit.
	// Command subcommand.
	// Command subcommand value. ex add location /home

	private:
		ushort port_ = 5899;
		immutable ushort BUFFER_SIZE = 1024;
		Socket server;
		bool isRunning;
}

@("Test SimpleServer")
unittest
{
	class TestServer : SimpleServer
	{
		override void onCommand(string[] commands)
		{
			writeln(commands);
		}
	}

	auto server = new TestServer;
	server.start();
	server.stop();

}
