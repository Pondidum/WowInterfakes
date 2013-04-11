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
require "wowinterfakes.loader"

require "wowinterfakes.templateCache"
require "wowinterfakes.events"
require "wowinterfakes.addonloader"

require "wowinterfakes.api.util.bit"
require "wowinterfakes.api.util.string"
require "wowinterfakes.api.util.table"
require "wowinterfakes.api.util.math"

requireAll(Api.root, "api")

require "wowinterfakes.api.custom.constants"

require "wowinterfakes.parsers.parsers"
require "wowinterfakes.parsers.tocParser"
require "wowinterfakes.parsers.luaParser"
require "wowinterfakes.parsers.xmlParser.parser"
requireAll(Api.root, "parsers.xmlParser.tags")


