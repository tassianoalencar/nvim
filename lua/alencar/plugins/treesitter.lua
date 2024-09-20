return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			vim.treesitter.language.register("markdown", { "md", "mdx" })
		end,
		opts = {
			ensure_installed = {
				"astro",
				"bash",
				"c",
				"comment",
				"cpp",
				"css",
				"diff",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"html",
				"php",
				"javascript",
				"jsdoc",
				"json",
				"json",
				"json5",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"pug",
				"python",
				"regex",
				"ruby",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"yaml",
				"vue",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			highlight = { enable = true, use_languagetree = true },
			indent = { enable = true },
			rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- automatically jump forward to matching textobj
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				swap = {
					enable = false,
					swap_next = { ["<leader>a"] = "@parameter.inner" },
					swap_previous = { ["<leader>A"] = "@parameter.inner" },
				},
			},
		},
	},
}
