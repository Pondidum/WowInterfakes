Api.parsers.xml.addTag("TexCoords", function(this)

	this.run = function(parent, element)

		local left = element.left or 0
		local right = element.right or 0
		local top = element.top or 0
		local bottom = element.bottom or 0

		this.builder.append('%s:SetTexCoord(%s, %s, %s, %s)', parent.variable, left, right, top, bottom)

	end

end)