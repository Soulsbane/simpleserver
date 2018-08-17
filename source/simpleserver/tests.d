module simpleserver.tests;
import std.stdio;

import simpleserver.client;
import simpleserver.server;

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
	//server.start();
	//server.stop();

}
