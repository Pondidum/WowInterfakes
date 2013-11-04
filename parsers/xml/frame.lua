local ns = ...
local builder = ns.builder

local tag = {
	processChildren = true,
	build = function(element)

		local decorator = function(target)

			local name = element.name
			local templates = element.inherits
			local parent = element.parent

			print("Creating frame", name, "parented to", parent)
			return builder.createFrame("Frame", name, parent, templates)
		end

		return decorator

	end,
}

ns.parsers.xml.addTag("Frame", tag)

-- Api.parsers.xml.addTag("Button", customise)
-- Api.parsers.xml.addTag("CheckButton", customise)
-- Api.parsers.xml.addTag("Cooldown", customise)
-- Api.parsers.xml.addTag("EditBox", customise)
-- Api.parsers.xml.addTag("Frame", customise)
-- Api.parsers.xml.addTag("MessageFrame", customise)
-- Api.parsers.xml.addTag("MovieFrame", customise)
-- Api.parsers.xml.addTag("ScrollChild", customise)
-- Api.parsers.xml.addTag("ScrollFrame", customise)
-- Api.parsers.xml.addTag("ScrollingMessageFrame", customise)
-- Api.parsers.xml.addTag("Slider", customise)
-- Api.parsers.xml.addTag("StatusBar", customise)

-- Api.parsers.xml.addTag("ArchaeologyDigSiteFrame", customise)
-- Api.parsers.xml.addTag("GameTooltip", customise)
-- Api.parsers.xml.addTag("Minimap", customise)
-- Api.parsers.xml.addTag("ColorSelect", customise)
-- Api.parsers.xml.addTag("WorldFrame", customise)

-- Api.parsers.xml.addTag("QuestPOIFrame", customise)
-- Api.parsers.xml.addTag("ScenarioPOIFrame", customise)
-- Api.parsers.xml.addTag("SimpleHTML", customise)

-- Api.parsers.xml.addTag("Model", customise)
-- Api.parsers.xml.addTag("DressUpModel", customise)
-- Api.parsers.xml.addTag("PlayerModel", customise)
-- Api.parsers.xml.addTag("TabardModel", customise)