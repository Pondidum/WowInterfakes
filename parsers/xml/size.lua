local ns = ...

local tag = {

	processChildren = false,
	
	build = function(element)

		local decorator = function(target)

			local x, y = 0, 0
			local abs = element[1]

			if abs then
				x = abs.x
				y = abs.y
			else
				x = element.x
				y = element.y
			end

			target:SetSize(x, y)

		end

		return decorator

	end,

}

ns.parsers.xml.addTag("Size", tag)
