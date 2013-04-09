local parser = function(path, addonName, namespace)

	local file = io.open(path, "r") 

	if file == nil then
		Api.debug.write("tocParser", "Unable to open file.", path)
		return 
	end

	Api.debug.write("tocParser", "BeginParse", path)

	local directory = io.path.getDirectory(path)

	for line in file:lines() do

		if line == nil then
			break
		end

		if line ~= '' and string.sub(line, 0, 2) ~= "##" then

			local subParser = Api.parsers.get(line)

			if not subParser then
				Api.debug.write("tocParser", "Unable to find a parser for line.", line)
			else
				subParser(io.path.combine(directory, line), addonName, namespace)	
			end

		end

	end

	Api.debug.write("tocParser", "EndParse.", path)

	file:close()

end

local canHandle = function(path)
	return string.sub(path, #path - 2) == "toc"
end

Api.parsers.add(canHandle, parser)