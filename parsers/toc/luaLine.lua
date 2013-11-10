local ns = ...
local log = ns.log.new("toc.luaLine")

local parser = {
	
	canHandle = function(root, path)
		return path:find(".lua$") ~= nil
	end,

	parse = function(root, path)
		
		log.debug("parsing", root .. path)
		
		local file = assert(loadfile(root .. path))

		if file then
			file()
		end

	end,
}

ns.parsers.toc.addLineParser(parser)
