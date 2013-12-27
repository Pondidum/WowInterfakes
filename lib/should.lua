local VERSION = "0.0.1"

local should = {

	haveCount = function(expected, collection, message)

		local actual = 0

		for k,v in pairs(collection) do
			actual = actual + 1
		end

		assert(actual == expected, string.format(message or "Expected %d elements, but there were %d.", expected, actual))

	end,

	equal = function(expected, actual, message)

		assert(actual == expected, string.format(message or "Expected %s and %s to be the same, but were different.", expected, actual))

	end,

	notEqual = function(expected, actual, message)

		assert(actual ~= expected, string.format(message or "Expected %s and %s to be different, but were the same.", expected, actual))

	end,

	haveKey = function(item, collection, message)

		assert(collection[item], string.format(message or "Expected the key %s to exist, but didn't.", item))

	end,

	notHaveKey = function(item, collection, message)

		assert(collection[item] == nil, string.format(message or "Expected the key %s to exist, but didn't.", item))

	end,

	haveValue = function(item, collection, message)

		local inCollection = false

		for k,v in pairs(collection) do
			if v == item then
				inCollection = true
			end
		end

		assert(inCollection, string.format(message or "Expected %s to be in the collection, but it wasn't.", item))

	end,

	notHaveValue = function(item, collection, message)

		local inCollection = false

		for k,v in pairs(collection) do
			if v == item then
				inCollection = true
			end
		end

		assert(inCollection == false, string.format(message or "Expected %s to not be in the collection, but it was.", item))

	end,

}

return should
