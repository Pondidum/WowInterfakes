local ns = ...

local getGameTime = function()
	local parts = os.date('*t')

	return parts.hour, parts.min
end

ns.api.export("GetGameTime", getGameTime)
