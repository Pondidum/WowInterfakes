local parser = function(path, addonName, namespace)

	local content = loadfile(path)

	if content then
		content(addonName, namespace)
	end

end

local canHandle = function(path)
	return string.sub(path, #path - 2) == "lua"
end

Api.parsers.add(canHandle, parser)