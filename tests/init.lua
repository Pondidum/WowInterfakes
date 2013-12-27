local ns = ...

local lunatic = loadfile("lib\\lunatic.lua")()
local should = loadfile("lib\\should.lua")()

ns.tests = lunatic.new()
ns.should = should