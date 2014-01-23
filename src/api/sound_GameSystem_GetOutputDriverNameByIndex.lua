local ns = ...

local sound_GameSystem_GetOutputDriverNameByIndex = function()
	return "Default"
end

ns.api.export("Sound_GameSystem_GetOutputDriverNameByIndex", sound_GameSystem_GetOutputDriverNameByIndex)
