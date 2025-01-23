local M = {
  'stevearc/oil.nvim',
}

M.dependencies = { { 'echasnovski/mini.icons', opts = {} } }

---@module 'oil'
---@type oil.SetupOpts
M.opts = {
  view_options = {
    show_hidden = true,
  },
  float = {
    padding = 10,
  },
}

M.keys = {
  { '<leader>e', '<cmd>Oil --float<cr>', desc = 'Oil Explorer' }
}

return M
