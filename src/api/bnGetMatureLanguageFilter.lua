local ns = ...
local data = ns.data.battlenet

local bnGetMatureLanguageFilter = function()
	return data.matureFilter
end

ns.api.export("BNGetMatureLanguageFilter", bnGetMatureLanguageFilter)
