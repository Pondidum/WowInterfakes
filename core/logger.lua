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
		print(string.format("%s: ", level), ...)
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

setmetatable(logger, { __index = base })
ns.log = logger
