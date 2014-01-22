local ns = ...
local locales = {
	"enGB",
}

local getAvailableLocales = function()

	return unpack(locales)

end

ns.api.export("GetAvailableLocales", getAvailableLocales)
