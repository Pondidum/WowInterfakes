local ns = ...

local getLootThreshold = function()
	return 2
end

ns.api.export("GetLootThreshold", getLootThreshold)
