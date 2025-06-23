return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("hardtime").setup()

    local keymap = vim.api.nvim_set_keymap

    -- Toggle HardTime
    keymap('n', '<leader>uH', ':Hardtime toggle<CR>', { noremap = true, silent = true })
  end
}
