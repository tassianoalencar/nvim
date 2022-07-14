local present, lspsaga = pcall(require, "lspsaga")
if not present then
	return
end

local config = require("core.config")

lspsaga.init_lsp_saga({
	border_style = config.border,
	code_action_keys = {
		quit = "<Esc>",
		exec = "<CR>",
	},
	rename_action_quit = "<Esc>",
})
