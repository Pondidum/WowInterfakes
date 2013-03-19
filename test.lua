require "wowapi"

local loader = Api.AddonLoader.new("C:\\Program Files (x86)\\World of Warcraft\\Interface\\AddOns")
loader.addons = {"Dark.Core", "Dark.Nameplates", "Dark.Unitframes", "Dark.Raids", "Dark.Warface"}
loader.debug = false
loader.load()

print("Dark:", Dark)