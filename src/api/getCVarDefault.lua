local ns = ...

local cvars = {
	["locale"] = "enGB",
}

local getCVarDefault = function(name)
	return tostring(cvars[name] or "")
end

ns.api.export("GetCVarDefault", getCVarDefault)
