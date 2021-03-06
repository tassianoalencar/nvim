local present, lsp_signature = pcall(require, "lsp_signature")
if not present then
	return
end

local config = require("core.config")

lsp_signature.setup({
	hint_prefix = " " .. config.icons.info .. " ",
	bind = true,
	handler_opts = {
		border = config.border,
	},
	fix_pos = true,
	hint_enable = false,
})
