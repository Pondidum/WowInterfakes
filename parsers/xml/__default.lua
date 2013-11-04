local ns = ...

local tag = {
	build = function(element)

		return function(target)
			local name = "unknown"
			
			if target then
				name = target:GetName()
			end

			print("Applying", element:tag(), "to", name)
		end

	end
}

ns.parsers.xml.addTag("__default", tag)
--ns.parsers.xml.addTag("__default", {})