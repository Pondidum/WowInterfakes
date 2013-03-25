require "luaxml"

Api = {}

Api.export = function(name, action)
	_G[name] = action
end

require "wowapi.debugTools"
require "wowapi.util"

require "wowapi.util.bit"
require "wowapi.util.string"
require "wowapi.util.table"
require "wowapi.util.math"

require "wowapi.events"
require "wowapi.addonloader"

--maybe change to luafilesystem for crossplatform 
for file in io.popen("dir /b api"):lines() do
	
	if file:endsWith(".lua") then
		require("wowapi.api." .. file:sub(0, #file-4))
	end

end

--uibuilder here (frameXml parser)
require "wowapi.parsers.parsers"
require "wowapi.parsers.tocParser"
require "wowapi.parsers.luaParser"
require "wowapi.parsers.xmlParser"

require "wowapi.custom.constants"
require "wowapi.custom.fakeXml"

