local ns = ...

local getCurrentResolution = function()
	return 4	--see getScreenResolutions()
end

ns.api.export("GetCurrentResolution", getCurrentResolution)
