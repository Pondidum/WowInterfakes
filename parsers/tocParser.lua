local ns = ...

local lineParsers = {}

local lineParserBase = {
	canHandle = function(line)
		return false
	end
	parse = function(line)
	end,
}

local lineMeta = { __index = lineParserBase }

local addLineParser = function(parser)
	
	setmetatable(parser, lineMeta)
	table.insert(lineParsers, parser)
	
end

local findParsersFor = function(line)
	
	local matches = {}

	for i,v in ipairs(lineParsers) do
		
		if v.canHandle(line) then
			table.insert(matches, v)
		end

	end

	return matches

end

local tocParser = {

	parse = function(filePath)

		local file = file.open(filepath)

		if not file then
			return
		end

		for line in file:lines() do

			local parsers = findParsersFor(line)

			for i, parser in iparis(parsers) do
				parser.parse(line)
			end

		end

		file:close()

	end,

	addLineParser = addLineParser,

}