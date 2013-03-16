
Api = {}

Api.export = function(name, action)
	_G[name] = action
end

require "wowapi.util"
require "wowapi.events"
require "wowapi.addonloader"

require "wowapi.api.bit"
require "wowapi.api.fillLocalizedClassList"
require "wowapi.api.registerStaticConstants"

require "wowapi.api.createFrame"
require "wowapi.api.getSpellInfo"

--uibuilder here (frameXml parser)

require "wowapi.custom.constants"
require "wowapi.wow-ui-source.framexml.constants"
require "wowapi.wow-ui-source.framexml.globalstrings"

require "wowapi.custom.fakeXml"
--i'll write a blizzard addon loader at some point, this will do for now
require "wowapi.wow-ui-source.addons.Blizzard_CompactRaidFrames.Blizzard_CompactRaidFrameManager"


