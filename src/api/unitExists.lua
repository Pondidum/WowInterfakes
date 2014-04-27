local ns = ...

local units = {
	player = true,
}

local unitExists = function(unit)
	
	return units[string.lower(unit)]	

end

ns.api.export("UnitExists", unitExists)
