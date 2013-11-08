local ns = ...

local lineParsers = {}

local lineParserBase = {
	
	canHandle = function(line)
		return false
	end,

	parse = function(line)
	end,

}

local lineMeta = { __index = lineParserBase }

local addLineParser = function(parser)
	
	setmetatable(parser, lineMeta)
	table.insert(lineParsers, parser)
	
end

local findParsersFor = function(line)
	
	for i,v in ipairs(lineParsers) do
		
		if v.canHandle(line) then
			return v
		end

	end

	return nil

end

local tocParser = {

	parse = function(filePath)

		local file = io.open(filePath)

		local path, filename, extension = filePath:match("(.-)([^\\]-([^%.]+))$")

		if not file then
			return
		end

		for line in file:lines() do

			local parser = findParsersFor(line)

			if parser then
				parser.parse(path .. line)
			end
			
		end

		file:close()

	end,

	addLineParser = addLineParser,

}

ns.parsers.toc = tocParser