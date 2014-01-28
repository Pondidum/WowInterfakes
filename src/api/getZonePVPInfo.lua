local ns = ...

local getZonePVPInfo = function()
	return "contested", nil, nil
end

ns.api.export("GetZonePVPInfo", getZonePVPInfo)
