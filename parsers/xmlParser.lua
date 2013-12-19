local ns = ...
local log = ns.log:new("xmlParser")

local decoratorData = {

	new = function(self, config)

		return setmetatable(config, { __index = self })

	end,

	stepOut = false,
	file = file,
	element = element,
	build = function() end,
}

local tagNotFound = function(t, k) 
	return t.__default
end 

local tags = setmetatable({}, { __index = tagNotFound })

local xmlParser = {

	addTag = function(name, tag)
		tags[name] = tag
	end,

	getTag = function(name)
		return tags[name]
	end,

	parse = function(root, xmlTable)

		local isVirtual = function(element)
			return element.attributes.virtual == "true"
		end

		local function recurseTree(file, parent, chain)

			for i, element in ipairs(parent.elements) do

				local virtual = isVirtual(element)
				local currentChain = chain

				if virtual then
					currentChain = {}
				end
				
				if not element.tag then
					log.warn("No Tag on", element)
				else				

					local tag = element.tag
					local handler = tags[tag]

					if handler then

						local data = decoratorData:new({
							file = file,
							element = element,
							build = function(...) 
								return handler:build(...) 
							end,
						})

						table.insert(currentChain, data)
					
						if handler.processChildren and #element.elements > 0 then
							recurseTree(file, element, currentChain)
						end

						if handler.createsElement then
							table.insert(currentChain, decoratorData:new({ stepOut = true }))
						end

					end

					if virtual then
						ns.templateManager.addTemplate(element.attributes.name, currentChain)
					end

				end 
			end

		end

		local file = { 
			root = root 
		}
		
		log.debug("building chain")

		local handlerChain = {}
		recurseTree(file, xmlTable, handlerChain)

		log.debug("executing chain")
		
		local target = ns.stack.new()

		for i, handler in ipairs(handlerChain) do
		 	
		 	local result = handler.build(handler.file, handler.element, target.tip())

		 	if result then
		 		target.push(result)
	 		elseif handler.stepOut then
		 	 	target.pop()		
		 	end

		end

	end,

}

ns.parsers.xml = xmlParser
