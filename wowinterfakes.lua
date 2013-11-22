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
		-- ns.log:setFilters({
		-- 	["toc.xmlLine"] = true,
		-- })

		local builder = ns.builder
		builder.init()
		
		-- instead of writing frames to _G, write them here
		local store = {}
		ns.frameRegistry.setStore(store)

		local parser = ns.parsers.xml
		parser.parse("", xml.load("test.xml"))

		print("--------------------------------")
		print("tables:")
		for k,v in pairs(store) do
			print(k,v)
		end
		-- local file = "wow-ui-source\\framexml\\framexml.toc"
		-- local parser = ns.parsers.toc

		-- parser.parse(file)

	end,

})
