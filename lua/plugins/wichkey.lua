vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" }
})

local wk = require("which-key")

wk.setup({
  preset = "helix",
  delay = 100
})

wk.add({
  { "<leader>f",  group = "Find" },
  { "<leader>g",  group = "Git" },
  { "<leader>gc", group = "Conflict" },
  { "<leader>b",  group = "Buffers" },

  { "<leader>c",  group = "Code" },
  { "<leader>cf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Code Format" },
  { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Code Rename" },

  { "<leader>u",  group = "Ui" },
  { "<leader>uo", "<cmd>update<cr><cmd>source<cr>",    desc = "Update and Source" },
})

