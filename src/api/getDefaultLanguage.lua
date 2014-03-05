local ns = ...

local getDefaultLanguage = function()
	return "Orcish"
end

ns.api.export("GetDefaultLanguage", getDefaultLanguage)
