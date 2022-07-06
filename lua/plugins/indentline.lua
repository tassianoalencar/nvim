local present, indent = pcall(require, "indent_blankline")
if not present then
	return
end

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#201F2B gui=nocombine]])

indent.setup({
	char = "┊",
	show_trailing_blankline_indent = false,
	char_highlight_list = {
		"IndentBlanklineIndent1",
	},
	show_first_indent_level = true,
	use_treesitter = true,
	show_current_context = false,
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"packer",
		"NvimTree",
	},
})
