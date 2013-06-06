local customise = function(this)

	this.run = function(parent, element)
	
		this.buildVariable(element, parent.name)
	
		local parentVariable = "UIParent"		
		local layer = 'nil'
		local template = 'nil'

		if element.layer then
			layer = '"' .. element.layer .. '"'
		end

		if element.inherits then
			template = '"' .. element.inherits .. '"'
		end


		if parent.variable then
			parentVariable = parent.variable
		end

		this.builder.append('local %s = %s:CreateFontString(%s, %s, %s)', element.variable, parentVariable, this.buildName(element, parent.name), layer, template)

	end

end

Api.parsers.xml.addTag("FontString", customise)
Api.parsers.xml.addTag("ButtonText", customise)