local M = { 'folke/which-key.nvim' }

M.event = 'VeryLazy'

M.lazy = true

local normal_mode = {
  mode = 'n',
  { '<leader>u', group = ' Ui' },
  { '<leader>g', group = ' Git' },
}

M.opts = {
  preset = 'classic',
  show_help = true,
  spec = {
    normal_mode,
  },
}

return M
