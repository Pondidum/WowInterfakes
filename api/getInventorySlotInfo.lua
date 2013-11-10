local ns = ...

local slots = {}

slots["AmmoSlot"]          = { id = "INVSLOT_AMMO",     texture = "" }	
slots["BackSlot"]          = { id = "INVSLOT_BACK",     texture = "" }	
slots["Bag0Slot"]          = { id = 0, texture = "" }	
slots["Bag1Slot"]          = { id = 0, texture = "" }	
slots["Bag2Slot"]          = { id = 0, texture = "" }	
slots["Bag3Slot"]          = { id = 0, texture = "" }	
slots["ChestSlot"]         = { id = "INVSLOT_CHEST",    texture = "" }	
slots["FeetSlot"]          = { id = "INVSLOT_FEET",     texture = "" }	
slots["Finger0Slot"]       = { id = "INVSLOT_FINGER1",  texture = "" }	
slots["Finger1Slot"]       = { id = "INVSLOT_FINGER2",  texture = "" }	
slots["HandsSlot"]         = { id = "INVSLOT_HAND",     texture = "" }	
slots["HeadSlot"]          = { id = "INVSLOT_HEAD",     texture = "" }	
slots["LegsSlot"]          = { id = "INVSLOT_LEGS",     texture = "" }	
slots["MainHandSlot"]      = { id = "INVSLOT_MAINHAND", texture = "" }	
slots["NeckSlot"]          = { id = "INVSLOT_NECK",     texture = "" }	
slots["RangedSlot"]        = { id = "INVSLOT_RANGED",   texture = "" }	
slots["SecondaryHandSlot"] = { id = "INVSLOT_OFFHAND",  texture = "" }	
slots["ShirtSlot"]         = { id = "INVSLOT_BODY",     texture = "" }	
slots["ShoulderSlot"]      = { id = "INVSLOT_SHOULDER", texture = "" }	
slots["TabardSlot"]        = { id = "INVSLOT_TABARD",   texture = "" }	
slots["Trinket0Slot"]      = { id = "INVSLOT_TRINKET1", texture = "" }	
slots["Trinket1Slot"]      = { id = "INVSLOT_TRINKET2", texture = "" }	
slots["WaistSlot"]         = { id = "INVSLOT_WAIST",    texture = "" }	
slots["WristSlot"]         = { id = "INVSLOT_WRIST",    texture = "" }	

local getInventorySlotInfo = function(slotName)

	local data = slots[slotName]

	if data then
		return _G[data.id], data.texture
	else
		return nil, nil
	end

end

ns.api.export("GetInventorySlotInfo", getInventorySlotInfo)
