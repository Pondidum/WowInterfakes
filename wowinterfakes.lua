require("project")
require("luaxml")

project:new({

	files = project:io(function(io)

		io.addFile("logger.lua")

		io.addFilesIn("core")
		io.addFilesIn("widgets")

		io.addFile("parsers\\xmlParser.lua")
		
	end),

	run = function(ns)
		
		local builder = ns.builder
		builder.init()
		
		local xmlFile = xml.load("wow-ui-source\\framexml\\autoComplete.xml")
		local parser = ns.parsers.xmlParser

		parser.parse(xmlFile)

		local frame = ns.builder.createFrame("Frame", "Test", nil, "AutoCompleteEditBoxTemplate")

	end,

})
