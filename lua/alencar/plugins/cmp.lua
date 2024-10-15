--------------------------------------------------
-- Autocomplete
--------------------------------------------------
local M = {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lua",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	cmp.setup({
		completion = {
			completeopt = table.concat(vim.opt.completeopt:get(), ","),
		},

		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- Luasnip expand
			end,
		},

		mapping = cmp.mapping.preset.insert({
			-- Scroll text in documentation window
			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-d>"] = cmp.mapping.scroll_docs(4),
			-- Jump to the next placeholder in the snippet.
			["<C-f>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end),
			-- go to previous placeholder in the snippet
			["<C-b>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end),
			["<C-e>"] = cmp.mapping.abort(),
			["<C-y>"] = cmp.mapping(function(fallback)
				if cmp.visible() and cmp.get_selected_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert })
				else
					fallback()
				end
			end),
			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() and cmp.get_selected_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
				else
					fallback()
				end
			end),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),

		sources = cmp.config.sources({
			{ name = "nvim_lsp" }, -- LSP
			{ name = "nvim_lsp_signature_help" }, -- LSP for parameters in functions
			{ name = "supermaven" },
			{ name = "luasnip" }, -- Luasnip
		}, {
			-- { name = "nvim_lua" }, -- Lua Neovim API
			{ name = "buffer" },
			{ name = "path" }, -- Paths
		}),

		window = {
			completion = {
				winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
				scrollbar = false,
			},
			documentation = {
				winhighlight = "Normal:CmpDoc",
			},
		},
	})

	-- Use buffer source for `/` and `?` (don't enable `native_menu`, otherwise this won't work).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),

		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (don't enable `native_menu`, otherwise this won't work).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline({
			-- ["<C-y>"] = {
			-- 	c = cmp.mapping.close(), --avoids ghost text behavior with noice
			-- },
		}),
		sources = cmp.config.sources({
			{ name = "cmdline" },
		}, {
			{ name = "path" },
		}),
	})

	-- Add snippets from Friendly Snippets
	require("luasnip/loaders/from_vscode").lazy_load()
end

return M
