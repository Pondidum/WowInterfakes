local ns = ...

local unitIsConnected = function(unit)
	return true
end

ns.api.export("UnitIsConnected", unitIsConnected)
