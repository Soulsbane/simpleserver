/**
	A server that connects to the local network.
*/
module simpleserver.server;

import std.stdio;
import std.socket;
import std.conv;

/**
	A server that connects to the local network.
*/
class SimpleServer
{
	///Basic setup
	this()
	{
		server_ = new TcpSocket();

		server_.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, true);
		server_.bind(new InternetAddress(port_));
		server_.listen(1);
	}

	/**
		Starts the server using port 5899 by default.
	*/
	void start()
	{
		isRunning_ = true;

		while (isRunning_)
		{
			Socket client = server_.accept();
			char[BUFFER_SIZE] buffer;
			auto received = client.receive(buffer);
			string msg = to!string(buffer[0 .. received]);

			onMessage(client, msg);
			client.shutdown(SocketShutdown.BOTH);
			client.close();
		}
	}

	/**
		Stops the server.
	*/
	void stop()
	{
		isRunning_ = false;
	}

	/**
		Handles all messages sent to the server.

		Params:
			client = The socket that send the message.
			msg = The message that was sent.
	*/
	abstract void onMessage(Socket client, const string msg);

private:
	ushort port_ = 5899;
	immutable ushort BUFFER_SIZE = 1024;
	TcpSocket server_;
	bool isRunning_;
}
