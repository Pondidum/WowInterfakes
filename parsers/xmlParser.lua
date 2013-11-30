local ns = ...
local log = ns.log:new("xmlParser")

local tagBase = {
	postProcess = false,
	processChildren = true,

	build = function(self, file, element, target)
		return target
	end,

	parseValue = function(self, element)

		if element == nil then
			return nil
		end

		local abs = element.elements.AbsValue
		local rel = element.elements.RelValue

		local value

		if abs then
			value = tonumber(abs.attributes.val)
		elseif rel then
			value = tonumber(rel.attributes.val)
		end

		local this = {
			isAbs = abs ~= nil,
			isRel = rel ~= nil,
			value = value
		}

		return this

	end,

	parseInset = function(self, element)

		if element == nil then
			return nil
		end

		local insets

		if element.AbsInset then
			insets = element.elements.AbsInset	
		elseif element.RelInset then
			insets = element.elements.RelInset
		end

		local values = {
			left = insets.attributes.left or 0,
			right = insets.attributes.right or 0,
			top = insets.attributes.top or 0,
			bottom = insets.attributes.bottom or 0,
		}

		local this = {
			isAbs = element.elements.AbsInset ~= nil,
			isRel = element.elements.RelInset ~= nil,
			value = values,
		}

		return this 

	end,

}

local tagNotFound = function(t, k) 
	return t.__default
end 

local notFoundMeta = { __index = tagNotFound }
local tagBaseMeta = { __index = tagBase }

local tags = setmetatable({}, notFoundMeta)

local addTag = function(name, definition)
	
	setmetatable(definition, tagBaseMeta)
	tags[name] = definition
	
end

local xmlParser = {

	parse = function(root, xmlTable)

		local isVirtual = function(element)
			return element.attributes.virtual == "true"
		end

		local function recurseTree(file, parent, chain)

			local postChain = {}

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
							build = function(self, ...) 
								return handler:build(...) 
							end,
						}

						if handler.postProcess then
							table.insert(postChain, decoratorData)
						else
							table.insert(currentChain, decoratorData)
						
							if handler.processChildren then
								recurseTree(file, element, currentChain)
							end

						end


					end

					if virtual then
						ns.templateManager.addTemplate(element.attributes.name, currentChain)
					end

				end 
			end

			for i, decorator in ipairs(postChain) do
				table.insert(chain, decorator)
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
		 	
		 	local result = handler:build(handler.file, handler.element, target)

		 	if result then
		 		target = result
		 	end

		end

	end,

	addTag = addTag,

}

ns.parsers.xml = xmlParser
