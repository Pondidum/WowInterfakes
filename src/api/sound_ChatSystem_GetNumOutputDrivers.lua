local ns = ...

local sound_ChatSystem_GetNumOutputDrivers = function()
	return 1
end

ns.api.export("Sound_ChatSystem_GetNumOutputDrivers", sound_ChatSystem_GetNumOutputDrivers)
