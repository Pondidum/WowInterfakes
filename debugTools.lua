

local debugTools = {}

debugTools.enabled = false	
debugTools.write = function(...)

	if debugTools.enabled then
		Api.print("Api.Debug: ", ...)
	end

end

Api.debug = debugTools