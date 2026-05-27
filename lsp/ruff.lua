return {
  cmd = { 'ruff', 'server' }, -- O comando moderno do ruff que inicia o LSP
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },
  init_options = {
    settings = {
      -- Opções de configuração gerais do Ruff podem ir aqui
      logLevel = 'error',
    },
  },
}
