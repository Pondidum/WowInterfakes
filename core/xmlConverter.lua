local ns = ...
local log = ns.log:new("xmlConverter")

local function parse(parent, xmlElement)

	local this = {
		attributes = {},
		elements = {},
		tag = "",
		parent = nil,
		value = nil,
	}

	this.parent = parent

	if xmlElement.tag then

		this.tag = xmlElement:tag()

		for key, value in pairs(xmlElement) do

			if type(key) == "number" then

				if tonumber(key) > 0 then
					table.insert(this.elements, parse(this, value))
				end

			else
				this.attributes[key] = value
			end

		end

	else
		 this.tag = "CDATA"
		 this.value = xmlElement
	end

	return this

end

ns.xmlConverter = {
	parse = function(xmlTable)
		return parse (nil, xmlTable)
	end
}
