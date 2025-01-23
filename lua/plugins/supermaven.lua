local M = {
  "supermaven-inc/supermaven-nvim"
}

M.event = "VeryLazy"

M.opts = {
  keymaps = {
    accept_suggestion = "<C-l>",
    clear_suggestion = "<C-h>",
    accept_word = "<C-w>",
  },
  log_level = "warn",
  disable_inline_completion = false, -- disables inline completion for use with cmp
  disable_keymaps = false, -- disables built in keymaps for more manual control
}

return M
