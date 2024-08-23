------------------------------------------ AUTOCOMPLETION ------------------------------------------

---checks if the character preceding the cursor is text or whitespace
---@return boolean
local function is_preceding_character_text()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	return not (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s"))
end

local map_item = {
	source = {
		buffer = "BUF │",
		path = "PTH │",
		nvim_lsp = "LSP │",
		luasnip = "SNP │",

		nvim_lsp_signature_help = "",
	},
	type = {
		Class = " CLS",
		Color = " CLR",
		Constant = " CON",
		Constructor = " CTR",
		Enum = " ENM",
		EnumMember = " ENM",
		Event = " EVT",
		Field = " FLD",
		File = " FIL",
		Folder = " FOL",
		Function = " FUN",
		Interface = " INT",
		Keyword = " KEY",
		Method = " MTH",
		Module = " MOD",
		Operator = " OPR",
		Property = " PRP",
		Reference = " REF",
		Snippet = " SNP",
		Struct = " STR",
		Text = " TXT",
		TypeParameter = " TYP",
		Unit = " UNT",
		Value = " VAL",
		Variable = " VAR",
	},
}

return {
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		config = function()
			local function ismap(lhs, rhs)
				vim.keymap.set({ "i", "s" }, lhs, rhs, {})
			end

			local luasnip = require("luasnip")

			ismap("<C-F>", function()
				luasnip.jump(1)
			end)

			ismap("<C-B>", function()
				luasnip.jump(-1)
			end)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		cond = true,
		event = "VeryLazy",
		dependencies = {
			{ "hrsh7th/cmp-buffer", cond = true },
			{ "hrsh7th/cmp-path", cond = true },
			{ "hrsh7th/cmp-cmdline", cond = true },
			{ "hrsh7th/cmp-nvim-lsp", cond = true },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", cond = true },
			{ "saadparwaiz1/cmp_luasnip", cond = true },
			{ "L3MON4D3/LuaSnip", cond = true },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- overall autocompletion engine setup
			cmp.setup({
				mapping = {
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = { keyword_length = 2 },
				formatting = {
					expandable_indicator = true,
					fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						item.menu = map_item.source[entry.source.name] or entry.source.name
						item.abbr = vim.trim(item.abbr):sub(1, 40)
						item.kind = item.menu == "" and " " or map_item.type[item.kind]
						return item
					end,
				},
				sources = { -- CHECK: entry_filter attribute for a source
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path", option = { trailing_slash = true }, priority = 1 },
				},
				window = {
					completion = {
						border = "single",
						zindex = 100,
						scrolloff = 4,
						col_offset = 4,
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					},
					documentation = {
						border = "single",
						zindex = 100,
						scrolloff = 4,
						max_width = 60,
						max_height = 20,
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					},
				},
			})

			-- command line autocompletion setup
			local common_config = {
				mapping = {
					["<C-N>"] = { c = cmp.mapping.select_next_item() },
					["<C-P>"] = { c = cmp.mapping.select_prev_item() },
					["<Tab>"] = {
						c = function()
							_ = cmp.confirm() or cmp.complete()
						end,
					},
				},
				formatting = {
					fields = { "abbr" },
					format = function(_, item)
						return item
					end,
				},
			}
			local search_config = vim.deepcopy(common_config)
			search_config.sources = { { name = "buffer" } }
			cmp.setup.cmdline("/", search_config)
			local cmdline_config = vim.deepcopy(common_config)
			cmdline_config.sources = {
				{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
				{ name = "path", option = { trailing_slash = true } },
			}
			cmp.setup.cmdline(":", cmdline_config)
		end,
	},
}
