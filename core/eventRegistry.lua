local ns = ...

local eventMap = {}

local eventRegistry = {

	register = function(target, event)

		eventMap[event] = eventMap[event] or {}

		local targets = eventMap[event]

		targets[target] = true

	end,

	raise = function(event, ...)

		local targets = eventMap[event]

		if not targets then
			return
		end

		for target, _ in pairs(targets) do
			
			local scriptHandler = target:GetScript(event)

			if scriptHandler then

				scriptHandler(target, event, ...)

			end

		end

	end,

}

ns.eventRegistry = eventRegistry
