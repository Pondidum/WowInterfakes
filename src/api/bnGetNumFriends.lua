local ns = ...

local bnGetNumFriends = function()
	return 5, 2
end

ns.api.export("BNGetNumFriends", bnGetNumFriends)
