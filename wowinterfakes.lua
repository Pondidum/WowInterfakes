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
		
		io.addFile("api\\bit.lua")

		io.addFile("api\\fillLocalizedClassList.lua")
		io.addFile("api\\registerStaticConstants.lua")
		io.addFile("api\\createFrame.lua")
		io.addFile("api\\getItemQualityColor.lua")
		io.addFile("api\\getInventorySlotInfo.lua")

	end),

	run = function(ns)
		
		ns.log.enabled = true
		-- ns.log:setFilters({
		-- 	["toc.xmlLine"] = true,
		-- })

		local builder = ns.builder
		builder.init()
		
		-- local file = xml.load("wow-ui-source\\framexml\\WorldFrame.xml")
		-- local parser = ns.parsers.xml

		local file = "wow-ui-source\\framexml\\framexml.toc"
		local parser = ns.parsers.toc

		parser.parse(file)

	end,

})
