local ns = ...
local log = ns.log.new("toc.luaLine")

local parser = {
	
	canHandle = function(line)
		return line:find(".lua$") ~= nil
	end,

	parse = function(line)
		
		log.debug("parsing", line)
		
		
		local file = assert(loadfile(line))

		if file then
			file()
		end

	end,
}

ns.parsers.toc.addLineParser(parser)
