Alias = Alias or {}

-- ######################################################################################
-- WARNING: ALTERING ANYTHING BELOW THIS POINT WILL CORRUPT YOUR MORALS AND YOU WILL DIE.
-- ######################################################################################

--
-- Return 'args' as a pair by splitting the string at the first white-space.
--
function Alias.GetPair(args)
	local arg = {}
	if (args) then
		for count,value in pairs({string.match(args,"^(%S*)%s*(.-)$")}) do
			arg[count] = value
			Alias.Log(2, "# arg\[" .. count .. "\]: " .. value)
		end
		return arg
	else
		return nil
	end
end

--
-- Return the total number of pairs in the table 'args'.
--
function Alias.GetTableSize(args)
	local size = 0
	for temp in pairs(args) do
		size = size + 1
	end
	return size
end

--
-- Output 'args' to the chat window, but only when 'level' <= 'LogLevel'.
--
function Alias.Log(level, args)
	if (level <= Alias.LogLevel and args ~= "") then
		CHAT_SYSTEM:AddMessage(args)
	end
end

--
-- Delegate subcommands to the appropriate functions or call for general help.
--
function Alias.InputHandler(args)
	local arg = Alias.GetPair(args)
	local subcommands = {
		["add"]			= Alias.SubCommandAdd,
		["autoexec"]	= Alias.SubCommandAutoExec,
		["help"]		= Alias.SubCommandHelp,
		["inspect"]		= Alias.SubCommandInspect,
		["list"]		= Alias.SubCommandList,
		["loglevel"]	= Alias.SubCommandLogLevel,
		["remove"]		= Alias.SubCommandRemove
	}
	local subfunction = subcommands[string.lower(arg[1])]
	if (subfunction ~= nil and type(subfunction) == "function") then
		subfunction(arg[2])
	else
		Alias.SubCommandHelp()
	end
end

--
-- Sets a new slash command 'alias' which calls a function containing 'args' and some basic error-handling.
--
function Alias.SetAlias(alias, args)
	local arg = Alias.GetPair(args)
	if (alias == "" or arg == "") then return end
	SLASH_COMMANDS["/"..alias] = function(aliasArgs)
		if (SLASH_COMMANDS["/"..arg[1]] ~= nil and type(SLASH_COMMANDS["/"..arg[1]]) == "function") then
			Alias.Log(1, "|cFFFFFF/" .. alias .. " (" .. aliasArgs .. ")|r = /" .. arg[1] .. "|c888888" .. arg[2] .. "|r")
			if arg[2] then
				if (#aliasArgs > 0) then
					SLASH_COMMANDS["/"..arg[1]](arg[2].." "..aliasArgs)
				else
					SLASH_COMMANDS["/"..arg[1]](arg[2])
				end
			else
				SLASH_COMMANDS["/"..arg[1]](aliasArgs)
			end
		else
			Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFERROR|r: Target command |cFFFFFF/" .. arg[1] .. "|r used in alias |cFFFFFF/" .. alias .. "|r does not exist.")
		end
	end
end

--
-- /alias add <alias> <target command> [target command args]
--
function Alias.SubCommandAdd(args)
	local arg = Alias.GetPair(args)
	if (arg[1] ~= "" and arg[2] ~= "") then
	   	-- TODO: SetAlias really should return success/fail rather than just plowing ahead regardless.
	   	Alias.SetAlias(arg[1], arg[2])
		SaveData.Aliases[arg[1]] = {AutoExec=false, Target=arg[2]}
	   	Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFADD|r: Alias |cFFFFFF/" .. arg[1] .. "|r added successfully, new table size: " .. Alias.GetTableSize(SaveData.Aliases))
	else
		Alias.SubCommandHelp("add")
	end
end

--
-- /alias autoexec <alias>
--
function Alias.SubCommandAutoExec(args)
	if (args ~= "") then
		if SaveData.Aliases[args] ~= nil then
			if (SaveData.Aliases[args].AutoExec == nil or SaveData.Aliases[args].AutoExec == false) then
				SaveData.Aliases[args].AutoExec = true
			else
				SaveData.Aliases[args].AutoExec = false
			end
			Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFAUTOEXEC|r: Alias |cFFFFFF/" .. args .. "|r = " .. string.upper(tostring(SaveData.Aliases[args].AutoExec)))
		else
			Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFERROR|r: Alias |cFFFFFF/" .. args .. "|r does not exist, try |cFFFFFF/alias list|r.")
		end
	else
		Alias.SubCommandHelp("autoexec")
	end
end

--
-- /alias help [subcommand]
--
function Alias.SubCommandHelp(args)
	if (args == nil or Alias.HelpText[string.lower(args)] == nil) then
		Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFHELP|r")
		Alias.Log(0, Alias.HelpText["general"])
	else
		Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFHELP|r (|cFFFFFF"..string.upper(args).."|r)")
		Alias.Log(0, Alias.HelpText[string.lower(args)])
	end
end

--
-- /alias inspect <alias>
--
function Alias.SubCommandInspect(args)
	if (args ~= "") then
	   	if SaveData.Aliases[args] ~= nil then
			Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFINSPECT|r\nName: |cFFFFFF" .. args .. "|r\nAutoExec: |cFFFFFF" .. tostring(SaveData.Aliases[args].AutoExec) .. "|r\nTarget: |c888888" .. SaveData.Aliases[args].Target .. "|r")
   		else
			Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFERROR|r: Alias |cFFFFFF/" .. args .. "|r does not exist, try |cFFFFFF/alias list|r.")
   		end
	else
		Alias.SubCommandHelp("inspect")
	end
end

--
-- /alias list
--
function Alias.SubCommandList()
	local count = 0
	local list = {}
	for temp in pairs(SaveData.Aliases) do table.insert(list, temp) end
	table.sort(list)
	Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFLIST|r\n")
	for key,value in ipairs(list) do
		local arg = Alias.GetPair(SaveData.Aliases[value].Target)
		count = count + 1
		Alias.Log(0, string.format("%03d", count) .. ": |cFFFFFF/" .. value .. "|r = |c888888" .. arg[1] .. ":" .. string.len(arg[2]) .. ":" .. tostring(SaveData.Aliases[value].AutoExec) .. "|r")

	end
end

--
-- /alias loglevel <0-2>
--
function Alias.SubCommandLogLevel(args)
	if (args ~= "") then
		args = tonumber(args)
		if (type(args) == "number" and args >= 0 and args <= 2) then
			Alias.LogLevel = args
		else
			Alias.SubCommandHelp("loglevel")
		end
	end
	Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFLOGLEVEL|r = |cFFFFFF" .. Alias.LogLevel .. "|r")
end

--
-- /alias remove <alias>
--
function Alias.SubCommandRemove(args)
	if (args ~= "") then
	   	if SaveData.Aliases[args] ~= nil then
	   		SaveData.Aliases[args] = nil
	   		SLASH_COMMANDS["/"..args] = nil
			Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFREMOVE|r: Alias |cFFFFFF/" .. args .. "|r successfully removed, new table size: " .. Alias.GetTableSize(SaveData.Aliases))
	   	else
			Alias.Log(0, string.upper(Alias.Name) .. " |cFFFFFFERROR|r: Alias |cFFFFFF/" .. args .. "|r does not exist, try |cFFFFFF/alias list|r.")
	   	end
	else
		Alias.SubCommandHelp("remove")
	end
end

--
-- EVENT_ADD_ON_LOADED - Restore saved variables and activate the primary command.
--
local function OnEventAddOnLoaded(event, args)
	if args ~= Alias.Name then return end

	local defaultsavedata = {Aliases = {}}
	SaveData = ZO_SavedVars:NewAccountWide("AliasSavedVariables", 1, nil, defaultsavedata, GetWorldName())

	for key,value in pairs(SaveData.Aliases) do
		Alias.SetAlias(key, value.Target)
	end

	SLASH_COMMANDS["/alias"] = Alias.InputHandler
	EVENT_MANAGER:UnregisterForEvent(Alias.Name, EVENT_ADD_ON_LOADED)
end

--
-- EVENT_PLAYER_ACTIVATED - Shameless self-attribution and AutoExec execution.
--
local function OnEventPlayerActivated()
	Alias.Log(0, string.upper(Alias.Name) .. " v" .. Alias.Version	.. " by " .. string.upper(Alias.Author) .. " |cFFFFFFREADY|r")
	for key,value in pairs(SaveData.Aliases) do
		if value.AutoExec == true then
			Alias.Log(0, "- autoexec: |cFFFFFF/" .. key .. "|r")
			local arg = Alias.GetPair(value.Target)
			SLASH_COMMANDS["/"..arg[1]](arg[2])
		end
	end
	EVENT_MANAGER:UnregisterForEvent(Alias.Name, EVENT_PLAYER_ACTIVATED)
end

-- Registration of initial events.
EVENT_MANAGER:RegisterForEvent(Alias.Name, EVENT_ADD_ON_LOADED, OnEventAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(Alias.Name, EVENT_PLAYER_ACTIVATED, OnEventPlayerActivated)
