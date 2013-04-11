
requireAll = function(root, directory)

	local apiPath = root.. string.gsub(directory, "%.", "/")
	local lfs = require("lfs")

	for file in lfs.dir(apiPath) do
		
		if file ~= "." and file ~= ".." then

			if lfs.attributes(apiPath.."/"..file).mode ~= "directory" then

				local reqPath = "wowinterfakes." .. directory .. "." .. file:sub(0, #file-4)
				require(reqPath)

			end
		end

	end


end