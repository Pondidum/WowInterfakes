require "luaxml"

Api = {}

Api.export = function(name, action)
	_G[name] = action
end

require "wowapi.debugTools"
require "wowapi.util"

require "wowapi.parsers.parsers"
require "wowapi.parsers.tocParser"
require "wowapi.parsers.luaParser"
require "wowapi.parsers.xmlParser"

require "wowapi.events"
require "wowapi.addonloader"

require "wowapi.api.bit"

require "wowapi.api.fillLocalizedClassList"
require "wowapi.api.registerStaticConstants"
require "wowapi.api.getAddonMetadata"
require "wowapi.api.getItemQualityColor"
require "wowapi.api.unitClass"
require "wowapi.api.createFrame"
require "wowapi.api.getSpellInfo"
require "wowapi.api.isLoggedIn"

--uibuilder here (frameXml parser)

require "wowapi.custom.constants"
require "wowapi.wow-ui-source.framexml.constants"
require "wowapi.wow-ui-source.framexml.globalstrings"
require "wowapi.wow-ui-source.framexml.uiparent"
require "wowapi.wow-ui-source.framexml.unitpopup"
require "wowapi.wow-ui-source.framexml.UnitFrame"
require "wowapi.wow-ui-source.framexml.TargetFrame"
require "wowapi.wow-ui-source.framexml.ReputationFrame"



require "wowapi.custom.fakeXml"
--i'll write a blizzard addon loader at some point, this will do for now
require "wowapi.wow-ui-source.addons.Blizzard_CompactRaidFrames.Blizzard_CompactRaidFrameManager"



