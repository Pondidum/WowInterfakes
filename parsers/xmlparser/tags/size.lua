Api.parsers.xml.addTag("Size", function(this) 

	this.processChildren = false
	this.run = function(self, builder, parent, element)

		local x, y = 0, 0
		local abs = element[1]

		if abs then
			x = abs.x
			y = abs.y
		end

		builder.append('%s:SetSize(%s, %s)', parent.variable, x, y)
	end

end)
