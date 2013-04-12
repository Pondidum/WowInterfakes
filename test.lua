require "wowinterfakes"

Api.log.enabled = true
Api.log.level = Api.log.levels.debug

local loader = Api.AddonLoader.new()
loader.loadBlizzard()