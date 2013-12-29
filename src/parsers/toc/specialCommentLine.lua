local ns = ...

local parser = {
	
	canHandle = function(root, path)
		return path:find("^##") ~= nil
	end,

	parse = function(root, path)
		--print("toc.specialComment", line)
	end,
}

ns.parsers.toc.addLineParser(parser)