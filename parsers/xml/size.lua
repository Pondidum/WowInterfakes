local ns = ...

local tag = {

	processChildren = false,
	
	build = function(file, element)

		local decorator = function(target)

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

		return decorator

	end,

}

ns.parsers.xml.addTag("Size", tag)
