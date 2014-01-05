local ns = ...

local getMaxMultisampleFormatOnCvar = function()
	return 5
end

ns.api.export("GetMaxMultisampleFormatOnCvar", getMaxMultisampleFormatOnCvar)
