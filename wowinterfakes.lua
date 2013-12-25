local project = require("project")

local print = print

local wowinterfakes = project:new({

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

		local this = {

			log = ns.log,

			init = function()
				ns.builder.init()
			end,

			loadFrameXml = function(path)

				local parser = ns.parsers.toc
				parser.parse(path or "wow-ui-source\\framexml\\framexml.toc")

			end,

			framework = ns,

		}

		return this

	end,

})

return wowinterfakes
