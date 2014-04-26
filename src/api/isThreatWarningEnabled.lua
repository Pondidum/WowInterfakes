local ns = ...

local isThreatWarningEnabled = function()
	return 1
end

ns.api.export("IsThreatWarningEnabled", isThreatWarningEnabled)
