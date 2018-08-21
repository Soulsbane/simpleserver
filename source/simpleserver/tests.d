module simpleserver.tests;
import std.stdio;

import simpleserver.client;
import simpleserver.server;

@("Test SimpleServer")
unittest
{
	class TestServer : SimpleServer
	{
		override void onMessage(const string msg)
		{
			writeln(msg);
		}
	}

	auto server = new TestServer;
	server.start();

	// NOTE: Since SimpleServer blocks we will never make it here. This is more an example than a test.
	auto client = new SimpleClient;
	client.connect();
	client.send("quit");
	server.stop();
}
