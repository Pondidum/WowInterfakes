local ns = ...

local binds = {
	["AUTOLOOTTOGGLE"] = "SHIFT",
	["SELFCAST"] = "ALT",
	["FOCUSCAST"] = "NONE",
	["PICKUPACTION"] = "SHIFT",
}

local getModifiedClick = function(name)
	return binds[name]
end

ns.api.export("GetModifiedClick", getModifiedClick)
