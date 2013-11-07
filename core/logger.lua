local ns = ...

local levelMap = {
	debug = 0,
	info = 5,
	warn = 10,
	error = 15,
}

local logger = {
	enabled = false,
	level = levelMap.debug,
	levels = levelMap,
}

local write = function(level, ...)

	if logger.enabled and levelMap[level] >= logger.level then
		print(string.format("Api.%s: ", level), ...)
	end

end


logger.write = function(...)
	write("debug", ...)
end

logger.debug = function(...)
	write("debug", ...)
end

logger.info = function(...)
	write("info", ...)
end

logger.warn = function(...)
	write("warn", ...)
end

logger.error = function(...)
	write("error", ...)
end

ns.log = logger