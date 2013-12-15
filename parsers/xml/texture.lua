local ns = ...

local tag = ns.parsers.xmlTag:new({
	
	build = function(self, file, element, target)


		local name = element.attributes.name
		local layer = nil
		local templates = element.attributes.inherits
		local sublevel = nil

		target:CreateTexture(name, layer, templates, sublevel)

	end,

})

ns.parsers.xml.addTag("Texture", tag)
