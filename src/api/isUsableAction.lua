local ns = ...

local isUsableAction = function(slot)
	return true, nil
end

ns.api.export("IsUsableAction", isUsableAction)
