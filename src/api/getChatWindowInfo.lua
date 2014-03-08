local ns = ...

local getChatWindowInfo = function(index)
		--name, fontSize, r, g, b, a, shown, locked, docked, uninteractable
	return "ChatFrame" ..index, 12, 1, 1, 1, 0, true, true, nil, nil
end

ns.api.export("GetChatWindowInfo", getChatWindowInfo)
