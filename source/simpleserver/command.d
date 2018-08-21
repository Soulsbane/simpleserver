module simpleserver.command;

import std.array;
import simpleserver.server;

class CommandServer : SimpleServer
{
	void onCommand(const string[] commands)
	{
		switch(commands.length)
		{
			case 1:
				onCommand(commands[0]);
				break;
			case 2:
				onCommand(commands[0], commands[1]);
				break;
			case 3:
				onCommand(commands[0], commands[1], commands[2]);
				break;
			default:
				onNoCommands();
		}
	}

	override void onMessage(const string msg)
	{
		onCommand(msg.split);
	}

	abstract void onCommand(const string command);
	abstract void onCommand(const string command, const string subCommand);
	abstract void onCommand(const string command, const string subCommand, const string value);
	abstract void onNoCommands();
	// Add command in the form of
	// Command example: quit.
	// Command subcommand example:
	// Command subcommand value. example: add location /home
}
