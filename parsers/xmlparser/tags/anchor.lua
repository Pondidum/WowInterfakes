Api.parsers.xml.addTag("Anchor", function(this)

	this.processChildren = false
	this.run = function(self, builder, parent, element)

		local point = element.point or ""
		local x = element.x or 0
		local y = element.y or 0

		builder.append('%s:SetPoint("%s", %s, %s)', parent.variable, point, x, y)

	end

end)