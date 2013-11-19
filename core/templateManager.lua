local ns = ...
local log = ns.log:new("templateManager")

local templates = {}

local templateManager = {

	addTemplate = function(name, decoratorChain)

		log.debug("registering template", name)
		templates[name] = decoratorChain
	end,

	apply = function(name, target)

		local decoratorChain = templates[name]

		if decoratorChain then
			
			for i, decorator in ipairs(decoratorChain) do
				decorator(target)
			end

		else

			log.warn("unable to find template", name)
		end

	end,

}

ns.templateManager = templateManager
