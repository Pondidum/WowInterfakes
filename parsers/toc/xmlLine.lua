local ns = ...
local log = ns.log

require("luaxml")

local parser = {
	
	canHandle = function(line)
		return line:find(".xml$") ~= nil
	end,

	parse = function(line)
		
		log.debug("xmlLine", "parsing", line)		
		local file = xml.load(line)
		local xmlParser = ns.parsers.xml

		xmlParser.parse(file)

	end,
}

ns.parsers.toc.addLineParser(parser)
