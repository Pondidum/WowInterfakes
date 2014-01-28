local ns = ...
local log = ns.log:new("api.setCVar")
local cvars = ns.data.cvars

local setCVar = function(name, value)

	log.debug(name, cvars[name], "=>", value)

	cvars[name] = value

end

ns.api.export("SetCVar", setCVar)
