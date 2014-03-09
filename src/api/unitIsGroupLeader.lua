local ns = ...

local unitIsGroupLeader = function(unitOrName)
	return false
end

ns.api.export("UnitIsGroupLeader", unitIsGroupLeader)
