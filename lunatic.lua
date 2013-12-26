local VERSION = "0.0.2"

local testRunner = {}

testRunner.run = function(before, test, after)

	local old = getfenv()

	setfenv(1, setmetatable({}, { __index = old }))

	local action = function()

		if before then
			before()
		end

		local success, e = pcall(test)

		if after then
			after()
		end

		return success, e

	end

	local s, e = pcall(action)

	setfenv(1, old)

	return s, e

end

testRunner.runSet = function(set)

	local before = set.before
	local after = set.after

	local result = {}

	for k,v in pairs(set) do

		if k ~= "before" and k ~= "after" then
			result[k] = testRunner.run(before, v, after)
		end

	end

	return result

end

local testEngine = {

	new = function()

		local this = {}
		local sets = {}
		local results = {}

		this.add = function(name, set)

			assert(type(name) == "string", "must be a name/description of the test set.")
			assert(type(set) == "table", "must be a table of tests to run.")

			sets[name] = set
		end

		this.run = function()

			results = {}

			for name, set in pairs(sets) do
				results[name] = testRunner.runSet(set)
			end

		end

		this.results = function()
			return results
		end

		this.print = function()

			for name, setResults in pairs(results) do
				print(name .. ":")

				for testName, result in pairs(setResults) do
					print("  ", testName, result)
				end
			end

		end

		return this

	end,

	version = function()

		print("Lunatic.lua, version ".. VERSION)

	end,

}

return testEngine
