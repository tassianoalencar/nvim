return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    local conform = require("conform")
    local map = vim.keymap

    conform.setup {
      formatters_by_ft = {
        lua = { "stylua" },
        php = { "easy-coding-standard" },
        ["*"] = { "prettier" }
      }
    }

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    map.set("n", "<leader>cF", function()
      conform.format({
        lsp_format = "prefer",
        async = false,
        timeout_ms = 1000
      })
    end, { desc = "Code Format" })
  end
}
