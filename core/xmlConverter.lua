local ns = ...

require("luaxml")

local function parse(parent, xmlElement)

	local this = {
		attributes = {},
		elements = {},
		tag = "",
		parent = nil,
	}

	this.tag = xmlElement:tag()
	this.parent = parent

	for key, value in pairs(xmlElement) do

		if type(key) == "number" then

			if tonumber(key) > 0 then
				table.insert(this.elements, parse(this, value))
			end

		else
			this.attributes[key] = value
		end

	end

	return this

end

ns.xmlConverter = {
	parse = function(xmlTable)
		return parse (nil, xmlTable)
	end
}