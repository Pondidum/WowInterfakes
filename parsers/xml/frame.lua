local ns = ...
local builder = ns.builder
local log = ns.log:new("tag.frame")

local tag = {
	processChildren = true,
	build = function(element)

		local decorator = function(target)

			local name = element.name
			local templates = element.inherits
			local parent = element.parent

			log.debug(string.format("Creating frame %s, parented to %s", name or "nil", parent or "nil"))
			return builder.createFrame(element:tag(), name, parent, templates)
		end

		return decorator

	end,
}

ns.parsers.xml.addTag("Frame", tag)
ns.parsers.xml.addTag("WorldFrame", tag)
ns.parsers.xml.addTag("GameTooltip", tag)
ns.parsers.xml.addTag("Button", tag)
ns.parsers.xml.addTag("CheckButton", tag)
ns.parsers.xml.addTag("MessageFrame", tag)
ns.parsers.xml.addTag("StatusBar", tag)
ns.parsers.xml.addTag("ColorSelect", tag)
ns.parsers.xml.addTag("MovieFrame", tag)
