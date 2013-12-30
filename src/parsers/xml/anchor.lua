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

		local relativeFrame = element.attributes.relativeTo or target:GetParent()
		local relativePoint = element.attributes.relativePoint or point

		local x = fixValue(element.attributes.x) or 0
		local y = fixValue(element.attributes.y) or 0

		log.debug(string.format("applying anchor %s.%s to %s.%s", target:GetName(), point, tostring(relativeFrame), relativePoint))

		target:SetPoint(point, relativeFrame, relativePoint, x, y)

	end,
})

ns.parsers.xml.addTag("Anchor", tag)
