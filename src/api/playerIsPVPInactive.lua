local ns = ...

local playerIsPVPInactive = function(name)
	return false
end

ns.api.export("PlayerIsPVPInactive", playerIsPVPInactive)
