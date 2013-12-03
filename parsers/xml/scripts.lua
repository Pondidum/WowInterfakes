local ns = ...
local log = ns.log:new("tag.scripts")

local tag = ns.parsers.xmlTag:new({
	processChildren = false,

	build = function(self, file, element, target)

		for i, child in pairs(element.elements) do
			
			local scriptType = child.tag
			
			if #child.elements > 0 then

				local contents = child.elements[1].value
				local func = loadstring(contents)

				target:SetScript(scriptType, func)	

			end			

		end

	end	
})

ns.parsers.xml.addTag("Scripts", tag)
