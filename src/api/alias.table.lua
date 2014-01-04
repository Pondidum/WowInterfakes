local ns = ...

--not quite the same as table.wipe, but hey
local wipe = function(t)

	for k, v in pairs(t) do
		t[k] = nil
	end

end

table.wipe = wipe

ns.api.export("tinsert", table.insert)
