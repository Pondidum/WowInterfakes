local ns = ...
local log = ns.log:new("tags.include")

local tag = ns.parsers.xmlTag:new({
	processChildren = false,

	build = function(self, file, element, target)

		local root = file.root
		local path = element.attributes.file
		
		if path then

			log.debug("including", path)

			local file = xml.load(root .. path)
			local parser = ns.parsers.xml
			local sanitised = ns.xmlConverter.parse(file)

			parser.parse(root, sanitised)

		end

	end
})

ns.parsers.xml.addTag("Include", tag)
