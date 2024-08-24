local utils_cmp = require("alencar.utils.cmp")

return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	opts = function()
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

		local cmp = require("cmp")
		local defaults = require("cmp.config.default")()
		local auto_select = true

		return {
			sorting = defaults.sorting,
			auto_brackets = {},
			completion = {
				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
			},
			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = utils_cmp.confirm({ select = auto_select }),
				["<C-y>"] = utils_cmp.confirm({ select = true }),
				["<S-CR>"] = utils_cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
				["<C-CR>"] = function(fallback)
					cmp.abort()
					fallback()
				end,
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				expandable_indicator = true,
				fields = { "menu", "abbr", "kind" },
				format = function(entry, item)
					item.menu = utils_cmp.map_item.source[entry.source.name] or entry.source.name
					item.abbr = vim.trim(item.abbr):sub(1, 40)
					item.kind = item.menu == "" and " " or utils_cmp.map_item.type[item.kind]
					return item
				end,
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
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
		}
	end,
}
