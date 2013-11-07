local ns = ...

local tag = {
	processChildren = false,

	build = function(element)

		local decorator = function(target)

			for i, child in pairs(element) do
				
				local handler = element:tag()
				local call = element['function']

				--not sure i can just do it like this, might need _G[call]
				target:SetScript(handler, call)	

			end

		end	

		return decorator

	end,
}

ns.parsers.xml.addTag("Scripts", tag)