local ns = ...
local log = ns.log
local builder = ns.builder

local tag = {
	processChildren = true,
	build = function(element)

		local decorator = function(target)

			local name = element.name
			local templates = element.inherits
			local parent = element.parent

			log.debug("tag.frame", string.format("Creating frame %s, parented to %s", name, parent or "nil"))
			return builder.createFrame(element:tag(), name, parent, templates)
		end

		return decorator

	end,
}

ns.parsers.xml.addTag("Frame", tag)
ns.parsers.xml.addTag("WorldFrame", tag)
ns.parsers.xml.addTag("GameTooltip", tag)
ns.parsers.xml.addTag("Button", tag)
