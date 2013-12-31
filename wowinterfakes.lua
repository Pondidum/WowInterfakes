local project = loadfile("lib\\project.lua")()

local print = print

local wowinterfakes = project:new({

	files = project:io(function(io)

		io.addFile("src\\core\\logger.lua")	-- load this before other things!

		io.addFilesIn("src\\core")

		io.addFile("src\\widgets\\widgetMetaBuilder.lua")
		io.addFile("src\\widgets\\builder.lua")
		io.addFilesIn("src\\widgets")

		io.addFile("src\\parsers\\namespace.lua")
		io.addFilesIn("src\\parsers")
		io.addFilesIn("src\\parsers\\xml")
		io.addFilesIn("src\\parsers\\toc")
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
