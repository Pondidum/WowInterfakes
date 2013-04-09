Api.parsers.xml.addTag("Frame", {

	run = function(self, builder, parent, element)

		if element.virtual then
			Api.templates.add(element.name, element)
			Api.debug.write("xmlParser", string.format("Adding template '%s'.", element.name))

			return
		end

		self.buildVariable(element)

		builder.append("")
		builder.append('local %s = CreateFrame("Frame", %s, UIParent)', element.variable, self.buildName(element))

		if element.parentKey then
			builder.append("%s.%s = %s", parent.variable, element.parentKey, element.variable)
		end

	end,
	
})
