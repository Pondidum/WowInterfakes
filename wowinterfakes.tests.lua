local project = loadfile("lib\\project.lua")()

local testProject = project:new({

	files = project:io(function(io)

		io.addFile("tests\\init.lua")
		io.addFilesIn("tests")

	end),

	run = function(ns)

		local wow = require("wowinterfakes").run()

		wow.log.config.enabled = false
		wow.log.config.level = "debug"

		wow.init()

		ns.wow = wow.framework

		ns.tests.run()
		ns.tests.print()

	end,

})


testProject.run()
