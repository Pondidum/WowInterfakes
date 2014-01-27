#What is it?

WowInterfakes is a library which fakes the entire of the World of Warcraft UI - from a code perspective at least.

This means it can parse the FrameXml, handle frame templates and provides a local version of the WoW Api.

This is a work in progress, things on the to-do list are:

* Data DB - `GetSpellInfo()` etc should work properly
* Data scraper? Wowhead/WowApi for getting spell data, and storing locally?

#Usage

```lua
local wow = require("wowinterfakes").run()
wow.init()
wow.loadFrameXml()
```

#Todo:

* FrameXml doesn't load completely.
* Many missing API functions
* API returns are mostly hard coded or use local lookups
* No character interation api
