local customise = function(this)

	this.run = function(self, builder, parent, element)

		if element.virtual then
			
			Api.debug.write("xmlParser", string.format("Adding template '%s'.", element.name))
			
			Api.templates.add(element.name, element)
			this.processChildren = false

			return
			
		end

		self.buildVariable(element)
		local typeToCreate = element:tag()

		builder.append("")
		builder.append('local %s = CreateFrame("%s", %s, UIParent)', element.variable, typeToCreate, self.buildName(element))

		if element.parentKey then
			builder.append("%s.%s = %s", parent.variable, element.parentKey, element.variable)
		end

	end

end

Api.parsers.xml.addTag("Button", customise)
Api.parsers.xml.addTag("CheckButton", customise)
Api.parsers.xml.addTag("Cooldown", customise)
Api.parsers.xml.addTag("EditBox", customise)
Api.parsers.xml.addTag("Frame", customise)
Api.parsers.xml.addTag("MessageFrame", customise)
Api.parsers.xml.addTag("ScrollChild", customise)
Api.parsers.xml.addTag("ScrollFrame", customise)
Api.parsers.xml.addTag("ScrollingMessageFrame", customise)
Api.parsers.xml.addTag("Slider", customise)
Api.parsers.xml.addTag("StatusBar", customise)

Api.parsers.xml.addTag("ArchaeologyDigSiteFrame", customise)
Api.parsers.xml.addTag("GameTooltip", customise)
Api.parsers.xml.addTag("Minimap", customise)
Api.parsers.xml.addTag("ColorSelect", customise)


Api.parsers.xml.addTag("QuestPOIFrame", customise)
Api.parsers.xml.addTag("ScenarioPOIFrame", customise)
Api.parsers.xml.addTag("SimpleHTML", customise)

Api.parsers.xml.addTag("Model", customise)
Api.parsers.xml.addTag("DressUpModel", customise)
Api.parsers.xml.addTag("PlayerModel", customise)
Api.parsers.xml.addTag("TabardModel", customise)