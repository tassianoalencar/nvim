return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.api.nvim_set_hl(0, "MagoGhostText", { fg = "#6c7086" })

    vim.cmd [[colorscheme catppuccin]]
  end
}
