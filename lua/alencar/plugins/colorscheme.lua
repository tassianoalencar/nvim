local M = {
  "LunarVim/darkplus.nvim",
}

M.lazy = false
M.priority = 1000

function M.config()
  vim.cmd.colorscheme "darkplus"
end

return M
