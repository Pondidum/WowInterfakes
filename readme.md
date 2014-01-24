What is it?
===========

WowInterfakes is a library which fakes the entire of the World of Warcraft UI - from a code perspective at least.

This means it can parse the FrameXml, handle frame templates and provides a local version of the WoW Api.

This is a work in progress, things on the to-do list are:

* Dependency resolution - currently addons are loaded in the order specified
* Data DB - `GetSpellInfo()` etc should work properly
* Data scraper? Wowhead/WowApi for getting spell data, and storing locally?
