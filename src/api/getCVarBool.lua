local ns = ...
local log = ns.log:new("api.getCVarBool")
local cvars = ns.data.cvars

local getCVarBool = function(name)

	log.debug(name, cvars[name])

	local value = cvars[name]

	return value == "1" or value == "true"

end

ns.api.export("GetCVarBool", getCVarBool)
