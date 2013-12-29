local ns = ...

local isSecure = function()
	return true
end

ns.api.export("issecure", isSecure)
