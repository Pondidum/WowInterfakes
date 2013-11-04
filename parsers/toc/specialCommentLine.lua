local ns = ...

local parser = {
	
	canHandle = function(line)
		return false -- line:startsWith("##")
	end,

	parse = function(line)
		print("toc.specialComment", line)
	end,
}

ns.parsers.toc.addLineParser(parser)