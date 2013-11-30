local ns = ...

local tag = {
	processChildren = false,

	build = function(self, file, element, target)

		for i, child in pairs(element) do
			
			local handler = element.tag
			local call = element.attributes['function']

			--not sure i can just do it like this, might need _G[call]
			target:SetScript(handler, call)	

		end

	end	
}

ns.parsers.xml.addTag("Scripts", tag)
