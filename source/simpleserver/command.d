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

	/**
		Processes a command sent from a client.

		Params:
			client = The client that sent the command.
			command = The command.
	*/
	abstract void onCommand(Socket client, const string command);

	/**
		Processes a command sent from a client.

		Params:
			client = The client that sent the command.
			command = The command.
			subcommand = The subcommand.
	*/

	abstract void onCommand(Socket client, const string command, const string subCommand);
	/**
		Processes a command sent from a client.

		Params:
			client = The client that sent the command.
			command = The command.
			subcommand = The subcommand.
			value = The value of the subcommand.
	*/

	abstract void onCommand(Socket client, const string command, const string subCommand, const string value);

	/**
		Called if no arguments are sent.
	*/
	abstract void onNoCommands();

	// Add command in the form of
	// Command example: quit.
	// Command subcommand example:
	// Command subcommand value. example: add location /home
}
