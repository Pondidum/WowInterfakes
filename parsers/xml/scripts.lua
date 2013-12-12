local ns = ...
local log = ns.log:new("tag.scripts")


local scriptParameters = {
	OnLoad = "local self = ...",
}

local wrapScript = function(type, contents)
	
	local prefix = scriptParameters[type]

	if not prefix then
		return contents
	end

	return prefix .. "\n" .. contents

end

local tag = ns.parsers.xmlTag:new({
	processChildren = false,

	build = function(self, file, element, target)

		for i, child in pairs(element.elements) do
			
			local scriptType = child.tag
			
			local functionValue = child.attributes["function"]
			local contents

			if functionValue then

				 contents = functionValue .. "(...)"

			elseif #child.elements > 0 then

				local value = child.elements[1].value

				contents = wrapScript(scriptType, value)

			end			

			local compiled, errorMessage = loadstring(contents)

			if not compiled then
				log.warn("Error parsing script tag:", scriptType, errorMessage)
			else
				target:SetScript(scriptType, compiled)
			end

		end

	end	
})

ns.parsers.xml.addTag("Scripts", tag)
