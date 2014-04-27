local ns = ...

local getVoiceStatus = function(unit, channel)
	return 1
end

ns.api.export("GetVoiceStatus", getVoiceStatus)
