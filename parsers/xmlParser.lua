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
	
	local scripts = {}
	local tags = {}

	for i, element in ipairs(xmlFile) do

		local tag = element:tag()
		local handler = tagHandlers[tag]

		if handler then 
			
			local wrap = function() handler(element, directory, addonName, namespace) end

			if tag == "Script" then
				table.insert(scripts, wrap)
			else
				table.insert(tags, wrap)
			end

		end

	end

	for i, handler in ipairs(tags) do
		handler()
	end

	for i, handler in ipairs(scripts) do
		handler()
	end
	
	--Api.debug.write("xmlParser", "EndParse.", path)

end


local canHandle = function(path)
	return string.sub(path, #path - 2) == "xml"
end

Api.parsers.add(canHandle, parse)