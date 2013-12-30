local ns = ...
local log = ns.log:new("anchors")

local fixValue = function(value)
	
	if value == nil then
		return nil
	end

	if value == "" then
		return 0
	end

	return value:gsub("%a", "")
end

local tag = ns.parsers.xmlTag:new({

	processChildren = false,
	
	build = function(self, file, element, target)

		local point = element.attributes.point or ""

		log.debug(string.format("applying anchor %s to %s", point, target:GetName()))

		local relativeFrame = element.attributes.relativeTo or ""
		local relativePoint = element.attributes.relativePoint or  ""
		local x = fixValue(element.attributes.x) or 0
		local y = fixValue(element.attributes.y) or 0

		target:SetPoint(point, relativeFrame, relativePoint, x, y)

	end,
})

ns.parsers.xml.addTag("Anchor", tag)