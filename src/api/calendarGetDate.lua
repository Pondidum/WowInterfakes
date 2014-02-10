local ns = ...

local calendarGetDate = function()
	local parts = os.date('*t')

	return parts.wday, parts.month, parts.day, parts.year
end

ns.api.export("CalendarGetDate", calendarGetDate)
