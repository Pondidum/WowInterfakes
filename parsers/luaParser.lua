local parser = function(path, addonName, namespace)

	Api.log.info("luaParser", "BeginParse", path)

	local content = loadfile(path)

	if content then
		content(addonName, namespace)
	else
		Api.log.write("luaParser", "Unable to load file.", path)
	end

end

local canHandle = function(path)
	return string.sub(path, #path - 2) == "lua"
end

Api.parsers.add(canHandle, parser)