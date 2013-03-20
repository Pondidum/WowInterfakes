

local debugTools = {}

debugTools.enabled = false	
debugTools.write = function(...)

	if debugTools.enabled then
		print("Api.Debug: ", ...)
	end

end

Api.debug = debugTools