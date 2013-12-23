local ns = ...

local tag = ns.parsers.xmlTag:new({
	
	processChildren = false,
	createsElement = true,

	build = function(self, file, element, target)

		local name = element.attributes.name
		local templates = element.attributes.inherits

		local group = target:CreateAnimationGroup(name, templates)

		return group

	end

})

ns.parsers.xml.addTag("AnimationGroup", tag)
