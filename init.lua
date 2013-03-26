require "luaxml"

Api = {}

Api.export = function(name, action)
	_G[name] = action
end

Api.print = print

require "wowinterfakes.debugTools"
require "wowinterfakes.util"

require "wowinterfakes.util.bit"
require "wowinterfakes.util.string"
require "wowinterfakes.util.table"
require "wowinterfakes.util.math"

require "wowinterfakes.events"
require "wowinterfakes.addonloader"

--maybe change to luafilesystem for crossplatform 
for file in io.popen("dir /b api"):lines() do
	
	if file:endsWith(".lua") then
		require("wowinterfakes.api." .. file:sub(0, #file-4))
	end

end

--uibuilder here (frameXml parser)
require "wowinterfakes.parsers.parsers"
require "wowinterfakes.parsers.tocParser"
require "wowinterfakes.parsers.luaParser"
require "wowinterfakes.parsers.xmlParser"

require "wowinterfakes.custom.constants"
require "wowinterfakes.custom.fakeXml"

