local ns = ...

local eventMap = {}

local eventRegistry = {

	register = function(target, event)

		eventMap[event] = eventMap[event] or {}

		local targets = eventMap[event]

		targets[target] = true

	end,

}

ns.eventRegistry = eventRegistry