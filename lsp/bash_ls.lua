require('config.server_manager')('bash-language-server', 'npm i -g bash-language-server')

---@type vim.lsp.Config
return {
  cmd = { "bash-language-server" },
  filetypes = { "sh", "bash" },
}
