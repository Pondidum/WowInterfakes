require "wowapi"

Api.debug.enabled = true 


local loader = Api.AddonLoader.new("D:\\dev\\tools\\lua\\5.1\\lua\\wowapi\\wow-ui-source")
loader.addons = {"FrameXML"}
loader.load()

-- local loader = Api.AddonLoader.new("C:\\Program Files (x86)\\World of Warcraft\\Interface\\AddOns")
-- loader.addons = {"Dark.Core", "Dark.Nameplates", "Dark.Unitframes", "Dark.Raids", "Dark.Warface"}
-- loader.load()

--print("Dark:", Dark)