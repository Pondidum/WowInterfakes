local ns = ...
local builder = ns.builder

local tag = {
	processChildren = true,
	build = function(file, element)

		local decorator = function(target)

			local name = element.attributes.name
			local templates = element.attributes.inherits

			local parent = element.attributes.parent
			local current = element.parent

			while parent == nil and current ~= nil do

				if current.attributes.name then
					parent = current.attributes.name
					break
				end

				current = current.parent

			end

			return builder.createFrame(element.tag, name, parent, templates)
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
