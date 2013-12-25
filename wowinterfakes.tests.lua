local project = require("project")

local testProject = project:new({

	files = project:io(function(io)

		--io.addFile("tests\\init.lua")
		io.addFilesIn("tests\\")

	end),

	run = function(ns)

		local wow = require("wowinterfakes").run()

		wow.log.config.enabled = true
		wow.log.config.level = "debug"

		wow.init()

		local file = xml.load("test.xml")
		local content = wow.framework.xmlConverter.parse(file)
		local parser = wow.framework.parsers.xml

		parser.parse("", content)
	end,

})


testProject.run()
