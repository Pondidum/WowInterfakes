local ns = ...

local tag = ns.parsers.xmlTag:new({

	build = function(self, file, element, target)

		local name = element.attributes.name
		local layer = nil
		local templates = element.attributes.inherits

		local font = target:CreateFontString(name, layer, templates)

		local key = element.attributes.parentKey

		if key then
			target[key] = font
		end

	end,

})

ns.parsers.xml.addTag("FontString", tag)
ns.parsers.xml.addTag("ButtonText", tag)
