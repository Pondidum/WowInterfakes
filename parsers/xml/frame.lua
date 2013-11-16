local ns = ...
local builder = ns.builder

local tag = {
	processChildren = true,
	build = function(file, element)

		local decorator = function(target)

			local name = element.name
			local templates = element.inherits

			local parent = element.parent
			local current = element.parentElement

			while parent == nil and current ~= nil do

				if current.name then
					parent = current.name
					break
				end

				current = current.parentElement

			end

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
