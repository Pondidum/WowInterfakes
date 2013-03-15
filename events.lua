
local events = {}

Api.fireEvent = function(eventName, ...)

	local frames = events[eventName]

	if not frames then
		return
	end

	for frame,v in pairs(frames) do
	
		local script = frame:GetScript("OnEvent")

		if script then
			script(frame, eventName, ...)
		end

	end

end

Api.registerEvent = function(eventName, frame)

	if events[eventName] == nil then
		events[eventName] = {}
	end

	events[eventName][frame] = true

end