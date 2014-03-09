local ns = ...

local getText = function(token, gender)

	gender = gender or ""

	local result = _G[token..gender] or _G[token]

	assert(result)

	return result

end

ns.api.export("GetText", getText)
