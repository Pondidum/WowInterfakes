local ns = ...
local stringUtilities = {}

stringUtilities.trim = function(input)
	return input:match("^%s*(.-)%s*$")
end

stringUtilities.split = function(input, seperator)

	local fields = {}
	local pattern = string.format("([^%s]+)", seperator or ",")

	local action = function(match)
		table.insert(fields, stringUtilities.trim(match))
	end

	string.gsub(input, pattern, action)

	return fields

end

ns.stringUtilities = stringUtilities
