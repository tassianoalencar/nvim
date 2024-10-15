--------------------------------------------------
-- Barbar
--------------------------------------------------
local M = {
	"romgrk/barbar.nvim",
}

M.enabled = false

M.dependencies = {
	"lewis6991/gitsigns.nvim",
	"nvim-tree/nvim-web-devicons",
}

M.config = function()
	vim.g.barbar_auto_setup = false

	require("barbar").setup()

	vim.keymap.set("n", "<S-h>", "<cmd>BufferPrevious<cr>", {})
	vim.keymap.set("n", "<S-l>", "<cmd>BufferNext<cr>", {})
end

return M
