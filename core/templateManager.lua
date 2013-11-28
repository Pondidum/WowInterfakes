local ns = ...
local log = ns.log:new("templateManager")

local templates = {}

local templateManager = {

	addTemplate = function(name, handlerChain)

		log.debug("registering template", name)
		
		templates[name] = handlerChain

	end,

	apply = function(name, target)

		local handlerChain = templates[name]

		if handlerChain then

			local first = handlerChain[1]

			first.element.parent.attributes.name = target:GetName()

			for i = 1, #handlerChain do

				local handler = handlerChain[i]

				local element = handler.element
				local file = handler.file 

				local decorator = handler.build(file, element)

				decorator(target)

			end

		else

			log.warn("unable to find template", name)
		end

	end,

}

ns.templateManager = templateManager
