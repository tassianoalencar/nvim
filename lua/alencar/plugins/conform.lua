local formatters = {
  lua = { "stylua" }
}

local M = {
  "stevearc/conform.nvim",
}

M.opts = {
  formatters_by_ft = formatters,
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = false,
  },
}

return M
