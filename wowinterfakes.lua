require("project")

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
		
		local f1 = builder.createFrame()
		local f2 = builder.createFrame()

		print("f1", f1:GetWidth())
		print("f2", f2:GetWidth())

		f1:SetWidth(100)

		print("f1", f1:GetWidth())
		print("f2", f2:GetWidth())

	end,

})