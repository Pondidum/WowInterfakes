local ns = ...

local sound_GameSystem_GetNumOutputDrivers = function()
	return 1
end

ns.api.export("Sound_GameSystem_GetNumOutputDrivers", sound_GameSystem_GetNumOutputDrivers)
