/**
	Simple client for connecting to a SimpleServer.
*/
module simpleserver.client;

import std.stdio;
import std.socket;
import std.conv;

/**
	Simple client for connecting to a SimpleServer.
*/
class SimpleClient
{
	///
	this()
	{
		client_ = new TcpSocket();
	}

	/**
		Connect to a local server.

		Params:
			port = The port to use. 5899 by default.
	*/
	void connect(ushort port = 5899)
	{
		client_.connect(new InternetAddress(port));
	}

	/**
		Sends a message to server.

		Params:
			message = The message to send.
			waitForReceive = Wait for a response message.
	*/
	void send(const string message, bool waitForReceive = true)
	{
		client_.send(message);

		if (waitForReceive)
		{
			receive();
		}
	}

	/**
		Disconnect from the server.
	*/
	void disconnect()
	{
		client_.shutdown(SocketShutdown.BOTH);
		client_.close();
	}

	/**
		Receives the message.
	*/
	private void receive()
	{
		char[BUFFER_SIZE] buffer;
		auto received = client_.receive(buffer);
		string msg = to!string(buffer[0 .. received]);

		onMessage(msg);
	}

	/**
		Callback for receiving any messages sent to client.
	*/
	abstract void onMessage(const string msg);

private:
	TcpSocket client_;
	immutable ushort BUFFER_SIZE = 1024;
}
