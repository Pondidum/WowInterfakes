local ns = ...
local data = ns.data.battlenet

local bnSetMatureLanguageFilter = function(enabled)
	data.matureFilter = enabled
end

ns.api.export("BNSetMatureLanguageFilter", bnSetMatureLanguageFilter)
