local ns = ...
local log = ns.log:new("templateManager")

local templates = {}
local templateManager = {}

templateManager.addTemplate = function(name, handlerChain)

	log.debug("registering template", name)
	
	templates[name] = handlerChain

end

templateManager.apply = function(name, target)

	local handlerChain = templates[name]

	if handlerChain then

		log.debug("applying", name .. " to " .. target:GetName())

		local first = handlerChain[1]

		first.element.attributes.name = target:GetName()

		local stack = ns.stack.new()
		stack.push(target)

		for i = 1, #handlerChain do

			local handler = handlerChain[i]

			local element = handler.element
			local file = handler.file 

			local result = handler.build(file, element, stack.tip())

			local nextTemplate = element.attributes.inherits 

			if nextTemplate ~= nil and nextTemplate ~= "" then
				templateManager.apply(nextTemplate, stack.tip())
			end

			if result then
				stack.push(result)
			elseif handler.stepOut then
				stack.pop()
			end

		end

	else

		log.warn("unable to find template", name)
	end

end

ns.templateManager = templateManager
