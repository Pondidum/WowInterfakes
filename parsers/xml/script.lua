local ns = ...
local log = ns.log:new("tags.script")

local tag = {
	processChildren = false,

	build = function(file, element)

		local decorator = function(target)

			local file = element.file
			
			log.debug("running file", file)


		end	

		return decorator

	end,
}

ns.parsers.xml.addTag("Script", tag)
