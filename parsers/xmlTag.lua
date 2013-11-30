local ns = ...

local xmlTag = {

	new = function(self, definition)

		return setmetatable(definition, { __index = self })

	end,

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

ns.parsers.xmlTag = xmlTag
