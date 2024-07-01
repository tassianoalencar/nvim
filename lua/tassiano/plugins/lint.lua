return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function ()
    local lint = require("lint")

    lint.linters_by_ft = {
      php = { "phpstan" }
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function ()
        lint.try_lint()
      end
    })

    vim.keymap.set("n", "<leader>cl", function ()
      lint.try_lint()
    end, { desc = "Code Lint" })
  end
}
