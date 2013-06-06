local customise = function(this) 

	this.run = function(parent, element)

		if element.virtual then
			
			Api.log.write("xmlParser", string.format("Adding template '%s'.", element.name))
			
			element.virtual = nil
			Api.templates.add(element.name, element)
			this.processChildren = false

			return
		end
		
		this.buildVariable(element, parent.name)
		
		local prefix  = "local " .. element.variable
		local level = "nil"
		local template = "nil"

		if parent.level then
			level = '"' .. parent.level .. '"'
		end

		if element.inherits then
			template = '"' .. element.inherits .. '"'
		end

		this.builder.append("")
		this.builder.append('%s = %s:CreateTexture(%s, %s, %s)', prefix, parent.variable, this.buildName(element, parent.name), level, template)

		if element.parentKey then
			this.builder.append("%s.%s = %s", parent.variable, element.parentKey, element.variable)
		end

	end
	
end

Api.parsers.xml.addTag("Texture", customise)
Api.parsers.xml.addTag("BarTexture", customise)
Api.parsers.xml.addTag("CheckedTexture", customise)
Api.parsers.xml.addTag("DisabledTexture", customise)
Api.parsers.xml.addTag("DisabledCheckedTexture", customise)
Api.parsers.xml.addTag("HighlightTexture", customise)
Api.parsers.xml.addTag("NormalTexture", customise)
Api.parsers.xml.addTag("PushedTexture", customise)

Api.parsers.xml.addTag("ThumbTexture", customise)
Api.parsers.xml.addTag("ColorWheelTexture", customise)
Api.parsers.xml.addTag("ColorWheelThumbTexture", customise)
Api.parsers.xml.addTag("ColorValueTexture", customise)
Api.parsers.xml.addTag("ColorValueThumbTexture", customise)
