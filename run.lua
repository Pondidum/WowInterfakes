local project = require("wowinterfakes")
local wow = project.run()

wow.log.config.enabled = true
wow.log.config.level = "debug"

wow.log.config:addFilters(
	wow.log.filterFactory.new("blacklist", {"tag.__default"})
)

wow.init()
wow.loadFrameXml()
