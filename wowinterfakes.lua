require("project")

local print = print 

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
		ns.log:setFilters({
			--["eventRegistry"] = true,
		})

		ns.builder.init()
				
		-- local parser = ns.parsers.toc
		-- parser.parse("wow-ui-source\\framexml\\framexml.toc")

		-- setprinthandler(print)
		
		-- ns.eventRegistry.raise("ADDON_LOADED")
		-- ns.eventRegistry.raise("SPELLS_CHANGED")
		-- ns.eventRegistry.raise("PLAYER_LOGIN")
		-- ns.eventRegistry.raise("PLAYER_ENTERING_WORLD")

		
		local file = xml.load("test.xml")
		local content = ns.xmlConverter.parse(file)

		local parser = ns.parsers.xml

		parser.parse("", content)
		
	end,

})
