local VERSION = "0.0.1"

local getFilesToLoad = function(fileEntry)
	
	if fileEntry == nil then
		return {}
	end

	if type(fileEntry) == "function" then
		return fileEntry()
	end

	return fileEntry

end

local indexOf = function(table, value)

	for i,v in ipairs(table) do
		
		if v == value then
			return i
		end

	end
	
end

local fileHelper = {

	new = function()

		local lfs = require("lfs")
		local files = {}
		local this  = {}

		this.addFile = function(path)
			table.insert(files, path)
		end

		this.addFilesIn = function(path, filter)

			filter = filter or "%.lua"

			for file in lfs.dir(path) do

				local fullPath = path .. "\\" .. file

				if file ~= "." and file ~= ".." and lfs.attributes(fullPath).mode ~= "directory" then

					if file:find(filter) then
						table.insert(files, fullPath)
					end
					
				end

			end

		end

		this.excludeFile = function(path)
			table.remove(files, indexOf(files, path))
		end

		this.excludeFilesMatching = function(expression)

			local toRemove = {}

			for i, path in ipairs(files) do
				
				if path:find(expression) then
					table.insert(toRemove, path)
				end

			end

			for i, path in ipairs(toRemove) do
				this.excludeFile(path)
			end

		end

		this.listFiles = function()
			
			local seen = {}
			local result = {}
		
			for i, path in ipairs(files) do
				
				if not seen[path] then
					table.insert(result, path)
					seen[path] = true 
				end
		
			end
			
			return result 
			
		end

		return this 

	end,
}


project = {
	
	new = function(self, config)

		local files = getFilesToLoad(config.files)
		local run = config.run or function() end

		local ns = {}

		for i, filename in ipairs(files) do
			
			local content = assert(loadfile(filename))

			if filename and content then
				content(ns)
			end

		end

		run(ns)

	end,

	io = function(self, action)

		local helper = fileHelper.new()

		action(helper)

		return helper.listFiles()

	end,

	version = function()

		print("Project.lua, version ".. VERSION)

	end.

}
