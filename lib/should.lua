local VERSION = "1.0.0"

local should = {

	haveCount = function(expected, collection, message)

		local actual = 0

		for k,v in pairs(collection) do
			actual = actual + 1
		end

		assert(actual == expected, string.format(message or "Expected %s elements, but there were %s.",
												 tostring(expected),
												 tostring(actual)))

	end,

	equal = function(expected, actual, message)

		assert(actual == expected, string.format(message or "Expected '%s' and '%s' to be the same, but were different.",
												 tostring(expected),
												 tostring(actual)))

	end,

	notEqual = function(expected, actual, message)

		assert(actual ~= expected, string.format(message or "Expected '%s' and '%s' to be different, but were the same.",
												 tostring(expected),
												 tostring(actual)))

	end,

	haveKey = function(item, collection, message)

		assert(collection[item], string.format(message or "Expected the key '%s' to exist, but didn't.",
											   tostring(item)))

	end,

	notHaveKey = function(item, collection, message)

		assert(collection[item] == nil, string.format(message or "Expected the key '%s' to not exist, but didn't.",
													  tostring(item)))

	end,

	haveValue = function(item, collection, message)

		local inCollection = false

		for k,v in pairs(collection) do
			if v == item then
				inCollection = true
			end
		end

		assert(inCollection, string.format(message or "Expected '%s' to be in the collection, but it wasn't.",
										   tostring(item)))

	end,

	notHaveValue = function(item, collection, message)

		local inCollection = false

		for k,v in pairs(collection) do
			if v == item then
				inCollection = true
			end
		end

		assert(inCollection == false, string.format(message or "Expected '%s' to not be in the collection, but it was.",
													tostring(item)))

	end,

	beTrue = function(item, message)

		assert(item == true, string.format(message or "Expected '%s' to be True, but it wasn't.",
										   tostring(item)))

	end,

	beFalse = function(item, message)

		assert(item == false, string.format(message or "Expected '%s' to be True, but it wasn't.",
											tostring(item)))

	end,

	beNil = function(item, message)

		assert(item == nil, string.format(message or "Expected '%s' to be nil, but it was a %s.",
										  tostring(item),
										  type(item)))

	end,

	notBeNil = function(item, message)

		assert(item, string.format(message or "Expected item to not be nil, but it was.",
								   tostring(item)))

	end,

}

return should
