require "wowinterfakes"

Api.debug.enabled = true
Api.debug.level = Api.debug.levels.info

local loader = Api.AddonLoader.new()
loader.loadBlizzard()