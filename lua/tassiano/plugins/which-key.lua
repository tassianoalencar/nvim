return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")

    wk.register({
      f = {
        name = "Find",
        f = { "<cmd>Telescope find_files<cr>", "Files" },
        o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
        g = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "Grep" },
      },
      


      -- vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {})
      -- vim.keymap.set("n", "<leader>fr", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", {})
      -- vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
      -- vim.keymap.set("n", "<leader>r", "<cmd>Telescope buffers<cr>", {})
      -- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})


      t = {
        name = "Telescope",
        c = {
          name = "Code",
          d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        },
        t = { "<cmd>Telescope<cr>", "Telescope" },
        b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
        r = { "<cmd>Telescope registers<cr>", "Diagnostics" },
      }

    }, { prefix = "<leader>" });
  end
}
