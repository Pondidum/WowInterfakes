

local debugTools = {}

debugTools.enabled = false	
debugTools.write = function(...)

	if debugTools.enabled then
		Api.print("Api.Debug: ", ...)
	end

end

debugTools.warn = function(...)

	if debugTools.enabled then
		Api.print("Api.Warning: ", ...)
	end

end

Api.debug = debugTools