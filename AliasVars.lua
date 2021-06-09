Alias = Alias or {}

-- ######################################################################################
-- WARNING: ALTERING ANYTHING BELOW THIS POINT WILL CORRUPT YOUR MORALS AND YOU WILL DIE.
-- ######################################################################################

--
-- Addon Specifications
--
Alias.Name = "Alias"
Alias.Author = "jeremy.rm"
Alias.Version = "1.3.1"

--
-- General help and detailed subcommand command usage info.
--
Alias.HelpText = {
	general = [[
		|cFFFFFF/alias add <alias> <target command>|r |c888888[parameters]|r
		|cFFFFFF/alias autoexec <alias>|r
		|cFFFFFF/alias help|r |c888888[subcommand]|r
		|cFFFFFF/alias inspect <alias>|r
		|cFFFFFF/alias list|r
		|cFFFFFF/alias loglevel <0-2>|r
		|cFFFFFF/alias remove <alias>|r
	]],
	add = [[
		|cFFFFFF/alias add <alias> <target command>|r |c888888[parameters]|r
		Adds <alias> as an alias of <target command> with optional [parameters].
		Aliases are case-sensitive.
		If an alias exists with the same name it will be overwritten.
	]],
	autoexec = [[
		|cFFFFFF/alias autoexec <alias>|r
		Toggles the AutoExec status of <alias>.
		AutoExec enabled aliases are automatically executed at player activation.
		|cFFFFFFUse with caution!|r
	]],
	help = [[
		|cFFFFFF/alias help|r |c888888[subcommand]|r
		Display general help, or detailed subcommand help for [subcommand].
	]],
	inspect = [[
		|cFFFFFF/alias inspect <alias>|r
		Display the entire target command and parameters of <alias>.
	]],
	list = [[
		|cFFFFFF/alias list|r
		Display a sorted list of all saved aliases.
		List output is formatted as follows:
		#: NAME = (TARGET-COMMAND:TARGET-ARGS-LENGTH:AUTOEXEC)
	]],
	loglevel = [[
		|cFFFFFF/alias loglevel <0-2>|r
		Set the addon log level, from 0 to 2.
		0: General Output (Default)
		1: Alias Debug
		2: Addon Debug
	]],
	remove = [[
		|cFFFFFF/alias remove <alias>|r
		Removes <alias> from the saved aliases.
	]]
}

--
-- LogLevel Default
--
Alias.LogLevel = 0

--
-- SaveData Default
--
Alias.SaveData = {}
