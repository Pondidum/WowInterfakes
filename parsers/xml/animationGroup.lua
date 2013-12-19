local ns = ...

local tag = ns.parsers.xmlTag:new({
	
	processChildren = true,
	build = function(self, file, element, target)

		local name = element.attributes.name
		local templates = element.attributes.inherits

		target:CreateAnimationGroup(name, templates)

	end

})

ns.parsers.xml.addTag("AnimationGroup", tag)
