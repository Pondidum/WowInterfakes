local ns = ...
local builder = ns.builder

local tag = ns.parsers.xmlTag:new({

	processChildren = true,
	build = function(self, file, element, target)

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

			local scriptTag = element.get("Scripts")

			if scriptTag then

				local onLoadTag = scriptTag.get("OnLoad")

				if onLoadTag then

					local scripts = ns.parsers.xml.getTag("Scripts")

					scripts:build(file, scriptTag, frame)

					local script = frame:GetScript("OnLoad")

					script(frame)

				end

			end

		end

		-- process other attribs etc
		--
		--
		
		return frame

	end,
})

ns.parsers.xml.addTag("Frame", tag)
ns.parsers.xml.addTag("WorldFrame", tag)
ns.parsers.xml.addTag("GameTooltip", tag)
ns.parsers.xml.addTag("Button", tag)
ns.parsers.xml.addTag("CheckButton", tag)
ns.parsers.xml.addTag("MessageFrame", tag)
ns.parsers.xml.addTag("StatusBar", tag)
ns.parsers.xml.addTag("ColorSelect", tag)
ns.parsers.xml.addTag("MovieFrame", tag)
ns.parsers.xml.addTag("ScrollingMessageFrame", tag)