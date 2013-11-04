local ns = ...

local parser = {
	
	canHandle = function(line)
		return line:find("^##") ~= nil
	end,

	parse = function(line)
		print("toc.specialComment", line)
	end,
}

ns.parsers.toc.addLineParser(parser)