-- lua/settings/blankline.lua
local status_ok, blankline = pcall(require, "indent_blankline")

if not status_ok then
	return
end

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

blankline.setup({
	space_char_blankline = " ",
})
