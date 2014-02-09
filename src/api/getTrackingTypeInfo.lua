local ns = ...

local getTrackingInfo = function(name)
	return "Mailboxes", "", true, "other"
end

ns.api.export("GetTrackingInfo", getTrackingInfo)
