local ns = ...

local getCurrentMultisampleFormat = function()
	return 1
end

ns.api.export("GetCurrentMultisampleFormat", getCurrentMultisampleFormat)
