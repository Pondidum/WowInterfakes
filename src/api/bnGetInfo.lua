local ns = ...
local data = ns.data.battlenet

local bnGetInfo = function()
	return 0, nil
end

ns.api.export("BNGetInfo", bnGetInfo)
