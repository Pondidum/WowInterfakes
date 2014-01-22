local ns = ...
local log = ns.log:new("tags.frame")
local builder = ns.builder

local tag = ns.parsers.xmlTag:new({

	createsElement = true,
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

		end

		-- process other attribs etc

		if element.attributes.id then
			frame:SetID(element.attributes.id)
		end

		return frame

	end,
})

ns.parsers.xml.addTag("Frame", tag)
ns.parsers.xml.addTag("WorldFrame", tag)
ns.parsers.xml.addTag("GameTooltip", tag)
ns.parsers.xml.addTag("Button", tag)
ns.parsers.xml.addTag("CheckButton", tag)
ns.parsers.xml.addTag("MessageFrame", tag)
ns.parsers.xml.addTag("Slider", tag)
ns.parsers.xml.addTag("StatusBar", tag)
ns.parsers.xml.addTag("ColorSelect", tag)
ns.parsers.xml.addTag("MovieFrame", tag)
ns.parsers.xml.addTag("ScrollingMessageFrame", tag)
ns.parsers.xml.addTag("PlayerModel", tag)
ns.parsers.xml.addTag("DressUpModel", tag)
ns.parsers.xml.addTag("ScrollFrame", tag)
