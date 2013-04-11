Api.parsers.xml.addTag("Size", function(this) 

	this.processChildren = false
	this.run = function(parent, element)

		local x, y = 0, 0
		local abs = element[1]

		if abs then
			x = abs.x
			y = abs.y
		end

		this.builder.append('%s:SetSize(%s, %s)', parent.variable, x, y)
	end

end)
