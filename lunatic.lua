local VERSION = "0.0.3"

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

			local s, e = testRunner.run(before, v, after)

			result[k] = { success = s, message = e }

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

			local fails = {}

			print("Tests run:")

			for name, setResults in pairs(results) do
				print("  ", name .. ":")

				for testName, result in pairs(setResults) do
					print("    ", testName, result.success and "passed" or "failed" )

					if not result.success then
						fails[testName] = result
					end

				end

			end

			if next(fails) then

				print("Details")

				for testName, result in pairs(fails) do
					print("    ", testName, result.message)
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
