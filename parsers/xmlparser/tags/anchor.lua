local fixValue = function(value)
	
	if value == nil then
		return nil
	end

	return value:gsub("%a", "")
end

Api.parsers.xml.addTag("Anchor", function(this)

	this.processChildren = false
	this.run = function(parent, element)

		local point = element.point or ""
		local x = fixValue(element.x) or 0
		local y = fixValue(element.y) or 0

		this.builder.append('%s:SetPoint("%s", %s, %s)', parent.variable, point, x, y)

	end

end)