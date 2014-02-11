local ns = ...

local tag = ns.parsers.xmlTag:new({

	build = function(self, file, element, target)


		local name = element.attributes.name
		local layer = nil
		local templates = element.attributes.inherits
		local sublevel = nil

		local texture = target:CreateTexture(name, layer, templates, sublevel)

		local key = element.attributes.parentKey

		if key then
			target[key] = texture
		end

	end,

})

ns.parsers.xml.addTag("Texture", tag)
ns.parsers.xml.addTag("NormalTexture", tag)
ns.parsers.xml.addTag("PushedTexture", tag)
ns.parsers.xml.addTag("DisabledTexture", tag)
ns.parsers.xml.addTag("HighlightTexture", tag)
