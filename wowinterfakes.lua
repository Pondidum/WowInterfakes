require("project")

project:new({

	files = project:io(function(io)

		io.addFile("core\\logger.lua")	-- load this before other things!

		io.addFilesIn("core")
		io.addFilesIn("widgets")

		io.addFile("parsers\\namespace.lua")
		io.addFilesIn("parsers")
		io.addFilesIn("parsers\\xml\\")
		io.addFilesIn("parsers\\toc\\")
		io.addFilesIn("api\\")

	end),

	run = function(ns)
		
		ns.log.enabled = true

		ns.builder.init()
				
		local parser = ns.parsers.toc

		parser.parse("wow-ui-source\\framexml\\framexml.toc")

	end,

})
