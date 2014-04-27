local ns = ...

local isVoiceChatEnabled = function(unit)
	return 1
end

ns.api.export("IsVoiceChatEnabled", isVoiceChatEnabled)
