local securecall = function(target, ...)
	return target(...)
end

Api.export("securecall", securecall)