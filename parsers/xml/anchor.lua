local ns = ...

local fixValue = function(value)
	
	if value == nil then
		return nil
	end

	if value == "" then
		return 0
	end

	return value:gsub("%a", "")
end

local tag = {

	processChildren = false,
	
	build = function(element)

		local decorator = function(target)

			local point = element.point or ""
			local x = fixValue(element.x) or 0
			local y = fixValue(element.y) or 0

			target:SetPoint(point, x, y)

		end

		return decorator

	end,

}

ns.parsers.xml.addTag("Anchor", tag)
