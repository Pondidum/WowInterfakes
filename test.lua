require "wowapi"

local loader = Api.AddonLoader.new("wow-ui-source\\addons")
loader.addons = {""}
loader.debug = true
loader.load()
