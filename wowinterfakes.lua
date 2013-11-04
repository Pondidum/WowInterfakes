require("project")
require("luaxml")

project:new({

	files = project:io(function(io)

		io.addFile("core\\logger.lua")	-- load this before other things!

		io.addFilesIn("core")
		io.addFilesIn("widgets")

		io.addFile("parsers\\namespace.lua")
		io.addFilesIn("parsers")

		io.addFilesIn("parsers\\tags\\")
		
	end),

	run = function(ns)
		
		local builder = ns.builder
		builder.init()
		
		-- local xmlFile = xml.load("wow-ui-source\\framexml\\autoComplete.xml")
		-- local parser = ns.parsers.xml

		-- parser.parse(xmlFile)

		local tocFile = "wow-ui-source\\framexml\\framexml.toc"
		local parser = ns.parsers.toc

		parser.parse(tocFile)
	end,

})
