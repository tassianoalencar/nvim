vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" }
})

local wk = require("which-key")

wk.setup({
  preset = "helix",
  delay = 0
})

wk.add({
  { "<leader>f",  group = "Find" },
  { "<leader>g",  group = "Git" },
  { "<leader>gc", group = "Conflict" },
  { "<leader>b",  group = "Buffers" },
  { "<leader>c",  group = "Code" },
  { "<leader>u",  group = "Ui" },
  { "<leader>uo", "<cmd>update<cr><cmd>source<cr>",    desc = "Update and Source" },
})

