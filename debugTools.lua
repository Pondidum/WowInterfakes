local levelMap = {
	debug = 0,
	info = 5,
	warn = 10,
	error = 15,
}

local debugTools = {
	enabled = false,
	level = levelMap.debug,
	levels = levelMap,
}

local write = function(level, ...)

	if debugTools.enabled and levelMap[level] >= debugTools.level then
		Api.print(string.format("Api.%s: ", level), ...)
	end

end


debugTools.write = function(...)
	write("debug", ...)
end

debugTools.debug = function(...)
	write("debug", ...)
end

debugTools.info = function(...)
	write("info", ...)
end

debugTools.warn = function(...)
	write("warn", ...)
end

debugTools.error = function(...)
	write("error", ...)
end

Api.debug = debugTools