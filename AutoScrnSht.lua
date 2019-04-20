AutoScrnSht_Config = { }
-- "version"
-- "enabled"

local AutoScrnSht_Version = "0.01"
local waitTable = {};
local waitFrame = nil;
local AutoScrnSht_msg_Loaded = "Auto ScreenShot v%s loaded (/autoss)."

function AutoScrnSht_OnLoad()
	-- hide overlay
	AutoScrnSht_Overlay:Hide()
	-- register slash commands
	SLASH_AutoScrnSht1 = "/autoss"
	SlashCmdList["AutoScrnSht"] = AutoScrnSht_SlashCmd
	-- register events
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_LEVEL_UP")
    this:RegisterEvent("TIME_PLAYED_MSG")
end

function AutoScrnSht_Event()
	if (event == "PLAYER_LEVEL_UP") then
        if (AutoScrnSht_Config["enabled"] == 1) then
		    RequestTimePlayed()
        end
    elseif (event == "TIME_PLAYED_MSG") then
        if (AutoScrnSht_Config["enabled"] == 1) then
            Screenshot()
        end
	elseif (event == "VARIABLES_LOADED") then	
		-- display about message
		AutoScrnSht_print(string.format(AutoScrnSht_msg_Loaded, AutoScrnSht_Version))
		-- check profile
		if (AutoScrnSht_Config["version"] == nil) then
			AutoScrnSht_CreateProfile()
		end		
	end
end

function AutoScrnSht_SlashCmd(msg)
	local arg = ""
	local x = 0
	x = string.find(msg, " ")
	if (x ~= nil) then 
		arg = string.sub(msg, x+1)
		msg = string.sub(msg, 0, x-1)
	end
	if (msg == "on") then
		AutoScrnSht_print(": ON")
        AutoScrnSht_Config["enabled"] = 1
	elseif (msg == "off") then
		AutoScrnSht_print(": OFF")
        AutoScrnSht_Config["enabled"] = 0
    end
    
end

function AutoScrnSht_CreateProfile(options)
	AutoScrnSht_Config = {}
	AutoScrnSht_Config["version"] = AutoScrnSht_Version
	AutoScrnSht_Config["enabled"] = 1
end

function AutoScrnSht_print(msg)
	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("[AutoScrnSht] "..msg)
	end
end