local ns = ...

local unitHealth = function(unit)
	return 20000
end

ns.api.export("UnitHealth", unitHealth)
