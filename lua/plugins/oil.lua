local M = {
  'stevearc/oil.nvim',
}

M.dependencies = { { 'echasnovski/mini.icons', opts = {} } }

---@module 'oil'
---@type oil.SetupOpts
M.opts = {
  default_file_explorer = false,
  view_options = {
    show_hidden = true,
  }
}

M.keys = {
  { '<leader>e', '<cmd>Oil --float<cr>', desc = 'Oil Explorer' }
}

return M
