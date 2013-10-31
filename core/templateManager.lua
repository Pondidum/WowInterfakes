local ns = ...

local templates = {}

local templateManager = {

	addTemplate = function(name, decoratorChain)
		templates[name] = decoratorChain
	end,

	apply = function(name, target)

		local decoratorChain = templates[name]

		if decoratorChain then
			
			for i, decorator in ipairs(decoratorChain) do
				decorator(target)
			end
		end

	end,

}

ns.templateManager = templateManager
