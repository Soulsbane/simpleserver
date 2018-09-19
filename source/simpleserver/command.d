/**
	Syntactic sugar to processing server commands sent from the client.
*/
module simpleserver.command;

import std.array;
import std.socket;

import simpleserver.server;

/**
	Syntactic sugar to processing server commands sent from the client.
*/
class CommandServer : SimpleServer
{
	//
	private void onCommand(Socket client, const string[] commands)
	{
		switch (commands.length)
		{
		case 1:
			onCommand(client, commands[0]);
			break;
		case 2:
			onCommand(client, commands[0], commands[1]);
			break;
		case 3:
			onCommand(client, commands[0], commands[1], commands[2]);
			break;
		default:
			onNoCommands();
		}
	}

	override void onMessage(Socket client, const string msg)
	{
		onCommand(client, msg.split);
	}

	abstract void onCommand(Socket client, const string command);
	abstract void onCommand(Socket client, const string command, const string subCommand);
	abstract void onCommand(Socket client, const string command,
			const string subCommand, const string value);
	abstract void onNoCommands();
	// Add command in the form of
	// Command example: quit.
	// Command subcommand example:
	// Command subcommand value. example: add location /home
}
