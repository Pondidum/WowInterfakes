local ns = ...
local builder = ns.builder

local tag = {
	processChildren = true,
	build = function(file, element)

		local decorator = function(target)

			local isVirtual = element.attributes.virtual == "true"

			local frame

			if isVirtual then
				frame = target
			else
				local name = element.attributes.name
				local templates = element.attributes.inherits

				local parent = element.attributes.parent
				local parentElement = element.parent

				while parent == nil and parentElement ~= nil do

					if parentElement.attributes.name then
						parent = parentElement.attributes.name
						break
					end

					parentElement = parentElement.parent

				end

				frame = builder.createFrame(element.tag, name, parent, templates)
			end

			-- process other attribs etc
			--
			--
			
			return frame


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
