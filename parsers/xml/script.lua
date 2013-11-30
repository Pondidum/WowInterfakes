local ns = ...
local log = ns.log:new("tags.script")

local tag = {
	postProcess = true,
	processChildren = false,

	build = function(file, element, target)

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
}

ns.parsers.xml.addTag("Script", tag)
