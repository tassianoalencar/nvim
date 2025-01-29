return {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.keymap.set('n', '<leader>la', '<cmd>AerialToggle!<CR>')

    require('aerial').setup {
      on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
      manage_folds = true,
      layout = {
        min_width = 30,
      },
      open_automatic = function(bufnr)
        if true then return false end -- disable aerial for large files

        local excluded_filetypes = { "html", "sh", "http" }
        local filetype = vim.api.nvim_get_option_value("filetype", {
          buf = bufnr,
        })
        return not vim.tbl_contains(excluded_filetypes, filetype)
      end
    }
  end,
}
