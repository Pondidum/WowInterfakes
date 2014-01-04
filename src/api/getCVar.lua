local ns = ...

local cvars = {
	["gxMonitor"] = 0,
}

local getCVar = function(name)
	return tostring(cvars[name] or "")
end

ns.api.export("GetCVar", getCVar)
