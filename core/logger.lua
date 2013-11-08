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
	setFilters = function(self, filters)

		self.filters = filters
		self.hasFilters = next(logger.filterPrefix) ~= nil
			
	end,
}

local write = function(level, prefix, ...)
	
	local log = not logger.hasFilters or logger.filterPrefix[prefix]

	if logger.enabled and levelMap[level] >= logger.level and log then
		print(string.format("%s: %s:", level, prefix), ...)
	end

end

local base = {
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

logger.new = function(self, prefix)

	local wrapAndCall = function(t, k) 

		return function(...)
			base[k](prefix, ...)
		end

	end

	return setmetatable({}, { __index = wrapAndCall })

end

ns.log = logger
