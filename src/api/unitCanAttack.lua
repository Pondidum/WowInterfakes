local ns = ...

local unitCanAttack = function(unit, unitOther)
	return 1
end

ns.api.export("UnitCanAttack", unitCanAttack)
