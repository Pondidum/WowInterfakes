local ns = ...

local getChatWindowSavedPosition = function(index)
	return "BOTTOMLEFT", 10, 10
end

ns.api.export("GetChatWindowSavedPosition", getChatWindowSavedPosition)
