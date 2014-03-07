local ns = ...

local getNumFriends = function()
	return 5, 2
end

ns.api.export("GetNumFriends", getNumFriends)
