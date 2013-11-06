local ns = ...

local parser = {
	
	canHandle = function(line)
		return false
	end,

	parse = function(line)

	end,
}

ns.parsers.toc.addLineParser(parser)