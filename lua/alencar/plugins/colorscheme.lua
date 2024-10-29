--------------------------------------------------
-- Colorscheme
--------------------------------------------------
return {
	"marko-cerovac/material.nvim",
	config = function()
		require("material").setup({
			disable = {
				background = true,
			},

			contrast = {
				terminal = false, -- Enable contrast for the built-in terminal
				sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
				floating_windows = false, -- Enable contrast for floating windows
				cursor_line = false, -- Enable darker background for the cursor line
				lsp_virtual_text = false, -- Enable contrasted background for lsp virtual text
				non_current_windows = false, -- Enable contrasted background for non-current windows
				filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
			},
		})

		vim.cmd("colorscheme material")
	end,
}
