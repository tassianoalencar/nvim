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
    local util = require("config.util")

    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
      },
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = util.cmp_confirm({ select = auto_select }),
        ["<C-y>"] = util.cmp_confirm({ select = true }),
        ["<S-CR>"] = util.cmp_confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer"},
      }),
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    }
  end,
}

-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     { 'neovim/nvim-lspconfig' },
--     { 'hrsh7th/cmp-nvim-lsp' },
--     { 'hrsh7th/cmp-buffer' },
--     { 'hrsh7th/cmp-path' },
--     { 'hrsh7th/cmp-cmdline' },
--     { 'L3MON4D3/LuaSnip' },
--     { 'saadparwaiz1/cmp_luasnip' },
--     { "petertriho/cmp-git" }
--   },
--   config = function()
--     vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
--
--     local cmp = require("cmp")
--     local luasnip = require("luasnip")
--     local util = require("config.util")
--
--     cmp.setup({
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--       },
--       mapping = cmp.mapping.preset.insert({
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.abort(),
--         ['<CR>'] = util.cmp_confirm({ select = true })
--       }),
--       sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' }, -- For luasnip users.
--       }, {
--         { name = 'buffer' },
--       })
--     })
--
--     cmp.setup.filetype('gitcommit', {
--       sources = cmp.config.sources({
--         { name = 'git' },
--       }, {
--         { name = 'buffer' },
--       })
--     })
--     require("cmp_git").setup()
--
--     -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--     cmp.setup.cmdline({ '/', '?' }, {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = {
--         { name = 'buffer' }
--       }
--     })
--
--     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--     cmp.setup.cmdline(':', {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--         { name = 'path' }
--       }, {
--         { name = 'cmdline' }
--       }),
--     })
--   end
-- }
