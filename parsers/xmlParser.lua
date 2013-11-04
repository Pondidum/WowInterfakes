local ns = ...

local tagBase = {
	processChildren = true,

	build = function(element) 

		local decorator =  function(target)
			return target
		end

		return decorator

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
	parse = function(xmlTable)

		local isVirtual = function(element)
			return element.virtual == "true"
		end

		local function recurseTree(parent, chain)

			for i, element in ipairs(parent) do 
				
				local virtual = isVirtual(element)
				local currentChain = chain

				if virtual then
					currentChain = {}
				end
				
				if not element.tag then
					--print("No tag found on", element)
				else				

					local tag = element:tag()
					local handler = tags[tag]

					if handler then

						table.insert(currentChain, handler.build(element))

						if handler.processChildren then
							recurseTree(element, currentChain)
						end

					end

					if virtual then
						ns.templateManager.addTemplate(element.name, currentChain)
					end

				end 
			end

		end

		local handlerChain = {}
		recurseTree(xmlTable, handlerChain)

		local target

		for i, decorator in ipairs(handlerChain) do
		 	
		 	local result = decorator(target)

		 	if result then
		 		target = result
		 	end

		end

	end,

	addTag = addTag,

	newValueReader = function(element)

		if element == nil then
			return nil
		end

		local abs = element.AbsValue
		local rel = element.RelValue

		local value

		if abs then
			value = tonumber(abs.val)
		elseif rel then
			value = tonumber(rel.val)
		end

		local this = {
			isAbs = abs ~= nil,
			isRel = rel ~= nil,
			value = value
		}

		return this

	end,

	newInsetReader = function(element)

		if element == nil then
			return nil
		end

		local insets

		if element.AbsInset then
			insets = element.AbsInset	
		elseif element.RelInset then
			insets = element.RelInset
		end

		local values = {
			left = insets.left or 0,
			right = insets.right or 0,
			top = insets.top or 0,
			bottom = insets.bottom or 0,
		}

		local this = {
			isAbs = element.AbsInset ~= nil,
			isRel = element.RelInset ~= nil,
			value = values,
		}

		return this 

	end,

}

ns.parsers.xml = xmlParser
