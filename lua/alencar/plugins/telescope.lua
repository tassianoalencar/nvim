local telescope_border = {
	"─",
	"│",
	"─",
	"│",
	"┌",
	"┐",
	"┘",
	"└",
}

local M = {
	"nvim-telescope/telescope.nvim",
}

M.dependencies = {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
}

M.event = "VimEnter"

M.config = function()
	local builtin = require("telescope.builtin")
	local telescope = require("telescope")
	local keymap = vim.keymap.set

	telescope.setup({
		defaults = {
			borderchars = telescope_border,
			path_display = {
				filename_first = {
					reverse_directories = false,
				},
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	})

	telescope.load_extension("ui-select")
	telescope.load_extension("fzf")

	keymap("n", "<leader>ff", builtin.find_files, {})
	keymap("n", "<leader>fg", builtin.live_grep, {})
end

return M
