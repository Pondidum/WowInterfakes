local ns = ...

local getTime = function()
	local parts = os.date('*t')

	return parts.hour, parts.min
end

ns.api.export("GetTime", getTime)
