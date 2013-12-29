local ns = ...

local equipmentSetContainsLockedItems = function(name)
	return false
end

ns.api.export("EquipmentSetContainsLockedItems", equipmentSetContainsLockedItems)
