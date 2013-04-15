What is it?
-----------

WowInterfakes is a library which fakes the entire of the World of Warcraft UI - from a code perspective at least.

This means it can parse the FrameXml, handle frame templates and provides a local version of the WoW Api.

This is a work in progress, things on the to-do list are:

* Finish Xml Parsing (currently just parses it, not all elements are actually created)
* Dependency resolution - currently addons are loaded in the order specified
* Data DB - `GetSpellInfo()` etc should work properly
* Data scraper? Wowhead/WowApi for getting spell data, and storing locally?

Usage
----------

````lua

require("wowinterfakes")

-- set debug spam level...
Api.log.enabled = true	
Api.log.level = Api.log.levels.debug   --debug/info/warn/error

local loader = Api.AddonLoader.new()	

--guess what this does?
loader.loadBlizzard()

--specify addons to load (order matters at the moment)
loader.addons = { "Dark.Core", "Dark.Unitframes", "Dark.Nameplates", "Skada" }

--loads addons
loader.load()


--Features to be done:
------------------------------------------------------------------------------------

--this will fire PLAYER_LOGIN, PLAYER_ENTERING_WORLD etc
Api.player.login({
	name = "Darkend",
	level = 90,
	class = "SHAMAN",
	specialisation = "Enhancement",
	race = "pandaren",
	sex = "female",
	--etc etc
})

--fire combatlog, unit updates, OnUpdate etc etc
Api.player.cast("Stormstrike", Api.units.target)

````
