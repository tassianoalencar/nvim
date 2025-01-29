local M = { 'folke/which-key.nvim' }

M.event = 'VeryLazy'

M.lazy = true

local normal_mode = {
  mode = 'n',
  { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)"},
  { '<leader>u', group = ' Ui' },
  { '<leader>g', group = ' Git' },
  { '<leader>f', group = ' Find' },
  { '<leader>l', group = ' LSP' },
  { '<leader>b', group = ' Buffer' },
  { '<leader>lrn', function() vim.lsp.buf.rename() end, desc = "Rename" },

}

M.opts = {
  show_help = true,
  spec = {
    normal_mode,
  },
}

return M
