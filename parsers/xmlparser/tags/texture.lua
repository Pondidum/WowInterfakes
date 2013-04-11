local customise = function(this) 

	this.run = function(parent, element)

		if element.virtual then
			
			Api.debug.write("xmlParser", string.format("Adding template '%s'.", element.name))
			
			Api.templates.add(element.name, element)
			this.processChildren = false

			return
		end
		
		this.buildVariable(element)
		local prefix  = "local " .. element.variable
		local level = parent.level or "ARTWORK"

		this.builder.append("")
		this.builder.append('%s = %s:CreateTexture("%s", %s)', prefix, parent.variable, level, this.buildName(element))

		if element.parentKey then
			this.builder.append("%s.%s = %s", parent.variable, element.parentKey, element.variable)
		end

	end
	
end

Api.parsers.xml.addTag("Texture", customise)
Api.parsers.xml.addTag("CheckedTexture", customise)
Api.parsers.xml.addTag("DisabledTexture", customise)
Api.parsers.xml.addTag("HighlightTexture", customise)
Api.parsers.xml.addTag("NormalTexture", customise)
Api.parsers.xml.addTag("PushedTexture", customise)

Api.parsers.xml.addTag("ThumbTexture", customise)
Api.parsers.xml.addTag("ColorWheelTexture", customise)
Api.parsers.xml.addTag("ColorWheelThumbTexture", customise)
Api.parsers.xml.addTag("ColorValueTexture", customise)
Api.parsers.xml.addTag("ColorValueThumbTexture", customise)