local ns = ...

local getVideoCaps = function()

	--hasAnisotropic, hasPixelShaders, hasVertexShaders, hasTrilinear, hasTripleBufering, maxAnisotropy, hasHardwareCursor
	return 1, 1, 1, 1, 1, 4, 1

end

ns.api.export("GetVideoCaps", getVideoCaps)
