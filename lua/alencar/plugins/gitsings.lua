return {
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	opts = {
		numhl = true,
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 500,
		},
	},
	keys = {
		{ "<leader>gb", "<cmd>Gitsigns blame<cr>", desc = "Git blame" },
		{ "<leader>gl", "<cmd>Gitsigns blame_line<cr>", desc = "Git blame line" },
	},
}
