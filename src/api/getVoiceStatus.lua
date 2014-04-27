local ns = ...

local getVoiceStatus = function(unit)
	return 1
end

ns.api.export("GetVoiceStatus", getVoiceStatus)
