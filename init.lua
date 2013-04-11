require "luaxml"

Api = {}

Api.export = function(name, action)
	_G[name] = action
end

Api.print = print
Api.root =  debug.getinfo(1).source:gsub("init.lua", ""):gsub("@", "")

require "wowinterfakes.debugTools"
require "wowinterfakes.util"
require "wowinterfakes.stringBuilder"

require "wowinterfakes.templateCache"
require "wowinterfakes.events"
require "wowinterfakes.addonloader"

require "wowinterfakes.api.util.bit"
require "wowinterfakes.api.util.string"
require "wowinterfakes.api.util.table"
require "wowinterfakes.api.util.math"

local apiPath = Api.root.."api"
local lfs = require("lfs")

for file in lfs.dir(apiPath) do
	
	if file ~= "." and file ~= ".." then

		if lfs.attributes(apiPath.."/"..file).mode ~= "directory" then

			local reqPath = "wowinterfakes.api." .. file:sub(0, #file-4)
			require(reqPath)

		end
	end

end

require "wowinterfakes.api.custom.constants"
require "wowinterfakes.api.custom.fakeXml"

--uibuilder here (frameXml parser)
require "wowinterfakes.parsers.parsers"
require "wowinterfakes.parsers.tocParser"
require "wowinterfakes.parsers.luaParser"
--require "wowinterfakes.parsers.xmlParser"
require "wowinterfakes.parsers.xmlParser.parser"
require "wowinterfakes.parsers.xmlParser.tags.anchor"
require "wowinterfakes.parsers.xmlParser.tags.anchors"
require "wowinterfakes.parsers.xmlParser.tags.animationGroup"
require "wowinterfakes.parsers.xmlParser.tags.animations"
require "wowinterfakes.parsers.xmlParser.tags.color"
require "wowinterfakes.parsers.xmlParser.tags.font"
require "wowinterfakes.parsers.xmlParser.tags.fontString"
require "wowinterfakes.parsers.xmlParser.tags.frame"
require "wowinterfakes.parsers.xmlParser.tags.frames"
require "wowinterfakes.parsers.xmlParser.tags.layer"
require "wowinterfakes.parsers.xmlParser.tags.layers"
require "wowinterfakes.parsers.xmlParser.tags.script"
require "wowinterfakes.parsers.xmlParser.tags.scripts"
require "wowinterfakes.parsers.xmlParser.tags.size"
require "wowinterfakes.parsers.xmlParser.tags.texCoords"
require "wowinterfakes.parsers.xmlParser.tags.texture"

