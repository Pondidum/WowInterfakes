local ns = ...

local tag = ns.parsers.xmlTag:new({

	processChildren = false,
	
	build = function(self, file, element, target)

		local x, y = 0, 0
		
		local sub = element.elements.AbsDimension or element.elements.RelDimension or {}

		if sub and sub.attributes then
			x = sub.attributes.x
			y = sub.attributes.y
		else
			x = element.attributes.x
			y = element.attributes.y
		end

		target:SetSize(x, y)

	end
})

ns.parsers.xml.addTag("Size", tag)
