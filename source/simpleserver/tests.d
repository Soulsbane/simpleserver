module simpleserver.tests;
import std.stdio;

import simpleserver.client;
import simpleserver.server;

@("Test SimpleServer")
unittest
{
	class TestServer : SimpleServer
	{
		override void onMessage(Socket client, const string msg)
		{
			writeln(msg);
		}
	}

	class TestClient : SimpleClient
	{
		override void onMessage(const string msg) {}
	}

	auto server = new TestServer;
	server.start();

	// NOTE: Since SimpleServer blocks we will never make it here. This is more an example than a test.
	auto client = new TestClient;
	client.connect();
	client.send("quit");
	server.stop();
}
