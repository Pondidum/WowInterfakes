local ns = ...

local securecall = function(target, ...)

	if type(target) == "string" then
		target = _G[target]
	end

	return target(...)

end

ns.api.export("securecall", securecall)
