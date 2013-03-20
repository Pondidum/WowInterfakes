
local parsers = {}

Api.parsers = {

	add = function(canHandle, parse)
		table.insert(parsers, { canHandle = canHandle, parse = parse })
	end,

	get = function(path)

		for i, entry in ipairs(parsers) do
			
			if entry.canHandle(path) then
				return entry.parse
			end

		end

	end,

}