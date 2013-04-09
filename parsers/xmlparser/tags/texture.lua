Api.parsers.xml.addTag("Texture", {

	run = function(self, builder, parent, element)

		if element.virtual then
			Api.templates.add(element.name, element)
			Api.debug.write("xmlParser", string.format("Adding template '%s'.", element.name))

			return
		end
		
		self.buildVariable(element)
		local prefix  = "local " .. element.variable

		builder.append("")
		builder.append('%s = %s:CreateTexture("%s", %s)', prefix, parent.variable, parent.level, self.buildName(element))

		if element.parentKey then
			builder.append("%s.%s = %s", parent.variable, element.parentKey, element.variable)
		end

	end,
	
})