require "luaxml"

Api = {}

Api.export = function(name, action)
	_G[name] = action
end

require "wowapi.debugTools"
require "wowapi.util"

require "wowapi.events"
require "wowapi.addonloader"

require "wowapi.api.bit"
require "wowapi.api.format"

require "wowapi.api.fillLocalizedClassList"
require "wowapi.api.registerStaticConstants"
require "wowapi.api.getAddonMetadata"
require "wowapi.api.getItemQualityColor"
require "wowapi.api.unitClass"
require "wowapi.api.unitRace"
require "wowapi.api.unitSex"
require "wowapi.api.createFrame"
require "wowapi.api.getSpellInfo"
require "wowapi.api.isLoggedIn"
require "wowapi.api.getInventorySlotInfo"
require "wowapi.api.securecall"
require "wowapi.api.issecure"

--uibuilder here (frameXml parser)
require "wowapi.parsers.parsers"
require "wowapi.parsers.tocParser"
require "wowapi.parsers.luaParser"
require "wowapi.parsers.xmlParser"

require "wowapi.custom.constants"
require "wowapi.custom.fakeXml"
