return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = true
	end,
	opts = {},
	keys = {
		{ "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Buffer Previous" },
		{ "<S-l>", "<cmd>BufferNext<cr>", desc = "Buffer Netxt" },
	},
}
