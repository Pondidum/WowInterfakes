local tagHandlers = {}

tagHandlers.Script = function(tag, directory, addonName, namespace)

	local fileFragment = tag.file

	if not fileFragment then
		return
	end

	local path = io.path.combine(directory, fileFragment)
	local fileParser = Api.parsers.get(path)

	fileParser(path, addonName, namespace)

end

tagHandlers.Include = function(tag)
	--print("Include")
end

tagHandlers.Font = function(tag)
	--print("Font")
end

tagHandlers.Frame = function(tag)
	--print("Frame")
end

tagHandlers.Animation = function(tag)
	--print("Animation")
end

tagHandlers.AnimationGroup = function(tag)
	--print("AnimationGroup")
end

	
local parse = function(path, addonName, namespace)

	Api.debug.write("xmlParser", "BeginParse", path)

	local xmlFile = xml.load(path)
	local directory = io.path.getDirectory(path)

	for i, element in ipairs(xmlFile) do

		if tagHandlers[element:tag()] then
			tagHandlers[element:tag()](element, directory, addonName, namespace)
		end

	end
	
	--Api.debug.write("xmlParser", "EndParse.", path)

end


local canHandle = function(path)
	return string.sub(path, #path - 2) == "xml"
end

Api.parsers.add(canHandle, parse)