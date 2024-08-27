local colorscheme = "catppuccin"

return {

	-- catppuccin
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				no_italic = true,
				no_bold = true,
			})

			vim.cmd.colorscheme(colorscheme)
		end,
	},

	-- vscode
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vscode").setup({})
			vim.cmd.colorscheme(colorscheme)
		end,
	},

	-- flow
	{
		"0xstepit/flow.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("flow").setup({})
			vim.cmd.colorscheme(colorscheme)
		end,
	},

	{
		dir = "/home/tassiano/Code/opensource/anysphere.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- require("flow").setup({})
			vim.cmd.colorscheme(colorscheme)
		end,
	},
}
