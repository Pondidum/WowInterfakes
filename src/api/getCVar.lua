local ns = ...
local log = ns.log:new("api.getCVar")
local cvars = ns.data.cvars

local getCVar = function(name)

	log.debug(name, cvars[name])

	return cvars[name]

end

ns.api.export("GetCVar", getCVar)
