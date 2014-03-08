local ns = ...

local getChatWindowSavedDimensions = function(index)
	return 400, 150
end

ns.api.export("GetChatWindowSavedDimensions", getChatWindowSavedDimensions)
