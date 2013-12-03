local ns = ...
local log = ns.log:new("eventRegistry")

local eventMap = {}
local eventCounts = {}

local eventRegistry = {

	register = function(target, event)

		log.debug("registering event", event, "on", target:GetName())
		
		if not eventMap[event] then
			eventMap[event] = {}
			eventCounts[event] = 0
		end

		local targets = eventMap[event]

		if not targets[target] then
			eventCounts[event] = eventCounts[event] + 1
		end

		targets[target] = true

	end,

	raise = function(event, ...)

		local targets = eventMap[event]

		log.debug("firing event", event, "on", (eventCounts[event] or 0) .." frames")

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
