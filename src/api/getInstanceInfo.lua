local ns = ...

local getInstanceInfo = function(name)

	return "Dread Wastes", "none", 0, nil, nil, nil, nil, nil, nil
	--name, type, difficulty, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()
end

ns.api.export("GetInstanceInfo", getInstanceInfo)
