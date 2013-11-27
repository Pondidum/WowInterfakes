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
	
	build = function(file, element)

		local decorator = function(target)

			local point = element.attributes.point or ""
			local relativeFrame = element.attributes.relativeTo or ""
			local relativePoint = element.attributes.relativePoint or  ""
			local x = fixValue(element.attributes.x) or 0
			local y = fixValue(element.attributes.y) or 0

			target:SetPoint(point, relativeFrame, relativePoint, x, y)

		end

		return decorator

	end,

}

ns.parsers.xml.addTag("Anchor", tag)
