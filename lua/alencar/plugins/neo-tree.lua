return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	cmd = "Neotree",
	keys = {
		{ "<leader>e", ":Neotree toggle<CR>", desc = "NeoTree reveal" },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["\\"] = "close_window",
				},
			},
		},
	},
}
