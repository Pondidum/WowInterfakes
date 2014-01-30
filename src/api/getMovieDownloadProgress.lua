local ns = ...

local getMovieDownloadProgress = function()
	return nil, 0, 0
end

ns.api.export("GetMovieDownloadProgress", getMovieDownloadProgress)
