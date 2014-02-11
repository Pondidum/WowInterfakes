local ns = ...

local getChatWindowInfo = function(index)
	return "ChatFrame1", 12, 1, 1, 1, 0, true, true, true, nil
end

ns.api.export("GetChatWindowInfo", getChatWindowInfo)
