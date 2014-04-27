local ns = ...

local isVoiceChatEnabled = function()
	return 1
end

ns.api.export("IsVoiceChatEnabled", isVoiceChatEnabled)
