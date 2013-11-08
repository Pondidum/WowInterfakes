local ns = ...
local log = ns.log:new("tag.__default")

local tag = {
	build = function(element)

		return function(target)
			local name = "unknown"
			
			if target then
				name = target:GetName() or "nil"
			end

			log.debug(string.format("applying %s to %s", element:tag(), name))
		end

	end
}

ns.parsers.xml.addTag("__default", tag)
--ns.parsers.xml.addTag("__default", {})
