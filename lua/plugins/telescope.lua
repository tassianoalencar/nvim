local present, telescope = pcall(require, "telescope")
if not present then
	return
end

local actions = require("telescope.actions")
local config = require("core.config")

telescope.setup({
	defaults = {
		layout_strategy = "horizontal",
		borderchars = config.borderchars,
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = " " .. config.icons.arrow_right .. " ",
		entry_prefix = " " .. config.icons.circle_o .. " ",
		selection_caret = " " .. config.icons.circle .. " ",
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<Esc>"] = actions.close,
			},
		},
	},
})
