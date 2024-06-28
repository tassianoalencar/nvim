return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  config = function()
    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")
    local mason_tool = require("mason-tool-installer")

    mason.setup {}

    mason_lsp.setup {
      ensure_installed = {
        "lua_ls",
        "intelephense",
        "emmet_ls",
      }
    }

    mason_tool.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "black",
        "easy-coding-standard",
        "phpstan"
      }
    })
  end
}
