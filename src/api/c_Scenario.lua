local ns = ...

local scenario = {

	IsInScenario = function()
		return false
	end,
}

ns.api.export("C_Scenario", scenario)
