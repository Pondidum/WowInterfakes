require("project")

project:new({

	files = project:io(function(io)

		io.addFilesIn("widgets")
		
	end),

	run = function(ns)

	end,
})