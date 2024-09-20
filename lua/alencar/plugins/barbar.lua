return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	config = function()
		vim.g.barbar_auto_setup = false

		require("barbar").setup()

		vim.keymap.set("n", "<S-h>", "<cmd>BufferPrevious<cr>", {})
		vim.keymap.set("n", "<S-l>", "<cmd>BufferNext<cr>", {})
	end,
}
