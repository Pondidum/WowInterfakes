local ns = ...

local tag = ns.parsers.xmlTag:new({
	
	build = function(self, file, element, target)


		local name = element.attributes.name
		local layer = nil
		local templates = element.attributes.inherits


		target:CreateFontString(name, layer, templates)

	end,

})

ns.parsers.xml.addTag("FontString", tag)
ns.parsers.xml.addTag("ButtonText", tag)
