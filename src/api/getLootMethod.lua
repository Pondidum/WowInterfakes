local ns = ...

local getLootMethod = function()
	return "freeforall", nil, nil
end

ns.api.export("GetLootMethod", getLootMethod)
