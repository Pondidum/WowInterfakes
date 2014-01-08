local ns = ...
local log = ns.log:new("api.getCVar")

local cvars = {
	["gxMonitor"] = 1,
	["waterDetail"] = 1,
	["rippleDetail"] = 1,
	["reflectionMode"] = 3,
	["useUiScale"] = 0,
	["sunshafts"] = 0,
}

local getCVar = function(name)

	log.debug(name, cvars[name])

	return tostring(cvars[name] or "")
end

ns.api.export("GetCVar", getCVar)
