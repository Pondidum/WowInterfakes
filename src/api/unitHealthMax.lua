local ns = ...

local unitHealthMax = function(unit)
	return 20000
end

ns.api.export("UnitHealthMax", unitHealthMax)
