local ns = ...
local log = ns.log:new("tags.script")

local tag = ns.parsers.xmlTag:new({
	processChildren = false,

	build = function(self, file, element, target)

		local path = element.attributes.file
		
		if path then

			local root = file.root
			local file = assert(loadfile(root .. path))

			if file then
				
				log.debug("running file", root, path)

				file()

			end

		end

	end
})

ns.parsers.xml.addTag("Script", tag)
