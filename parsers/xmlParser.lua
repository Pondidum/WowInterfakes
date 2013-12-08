local ns = ...
local log = ns.log:new("xmlParser")

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
					--print("No tag found on", element)
				else				

					local tag = element.tag
					local handler = tags[tag]

					if handler then

						local decoratorData = { 
							file = file,
							element = element,
							build = function(...) 
								return handler:build(...) 
							end,
						}

						table.insert(currentChain, decoratorData)
					
						if handler.processChildren then
							recurseTree(file, element, currentChain)
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
		
		local target

		for i, handler in ipairs(handlerChain) do
		 	
		 	local result = handler.build(handler.file, handler.element, target)

		 	if result then
		 		target = result
		 	end

		end

	end,

}

ns.parsers.xml = xmlParser
