local present, themer = pcall(require, "themer")

if not present then
	return
end

local config = require("core.config")

themer.setup({
	colorscheme = config.theme,
})
