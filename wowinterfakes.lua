local project = loadfile("lib\\project.lua")()

local print = print
GlobalPrint = print

local wowinterfakes = project:new({

	files = project:io(function(io)

		io.addFile("src\\core\\logger.lua")	-- load this before other things!
		io.addFile("src\\core\\utilities.lua")
		io.addFile("src\\core\\stack.lua")
		io.addFilesIn("src\\core")

		io.addFile("src\\widgets\\widgetBuilder.lua")
		io.addFile("src\\widgets\\builder.lua")
		io.addFilesIn("src\\widgets")

		io.addFile("src\\parsers\\namespace.lua")
		io.addFilesIn("src\\parsers")
		io.addFilesIn("src\\parsers\\xml")
		io.addFilesIn("src\\parsers\\toc")

		io.addFile("src\\data\\namespace.lua")
		io.addFilesIn("src\\data")
		io.addFilesIn("src\\api")

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
