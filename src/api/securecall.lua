local ns = ...

local securecall = function(target, ...)
	return target(...)
end

ns.api.export("securecall", securecall)
