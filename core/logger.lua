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
	filterPrefix = {},
}

local write = function(level, prefix, ...)

	if logger.enabled and levelMap[level] >= logger.level then
		print(string.format("%s: %s:", level, prefix), ...)
	end

end

local base = {

	write = function(...)
		write("debug", ...)
	end,

	debug = function(...)
		write("debug", ...)
	end,

	info = function(...)
		write("info", ...)
	end,

	warn = function(...)
		write("warn", ...)
	end,

	error = function(...)
		write("error", ...)
	end,

}


logger.new = function(prefix)

	local wrapAndCall = function(t, k) 

		return function(...)
			base[k](prefix, ...)
		end

	end

	return setmetatable({}, { __index = wrapAndCall })

end

ns.log = logger
