local ns = ...
local log = ns.log:new("toc.xmlLine")

require("luaxml")

local parser = {
	
	canHandle = function(root, path)
		return path:find(".xml$") ~= nil
	end,

	parse = function(root, path)
		
		log.debug("parsing", root .. path)
		
		local file = xml.load(root .. path)

		local xmlParser = ns.parsers.xml
		local sanitised = ns.xmlConverter.parse(file)

		xmlParser.parse(root, sanitised)

	end,
}

ns.parsers.toc.addLineParser(parser)
