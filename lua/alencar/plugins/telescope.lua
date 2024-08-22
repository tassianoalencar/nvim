local telescope_border = {
  "─","│","─","│","┌","┐","┘","└"
}

local M = {
  "nvim-telescope/telescope.nvim"
}

M.dependencies = {
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
}

M.event = "VimEnter"

M.config = function ()
  local builtin = require("telescope.builtin")
  local telescope = require("telescope")
  local keymap = vim.keymap.set

  telescope.setup {
    defaults = {
      borderchars = telescope_border,
      path_display = {
        filename_first = {
          reverse_directories = false
        }
      },
    },
  }

  telescope.load_extension 'fzf'

  keymap("n", "<leader>ff", builtin.find_files, {})

end

return M
