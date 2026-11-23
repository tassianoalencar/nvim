-- Instalado pelo Mason (pacote `jdtls`). Requer Java 21+ no PATH.
-- Um workspace por projeto, guardado no cache do nvim.
---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local project = vim.fn.fnamemodify(config.root_dir or vim.fn.getcwd(), ':p:h:t')
    local workspace = vim.fn.stdpath('cache') .. '/jdtls/workspaces/' .. project

    return vim.lsp.rpc.start({
      'jdtls',
      '-data', workspace,
      '--jvm-arg=-Xms1g',
      '--jvm-arg=-Xmx2G',
    }, dispatchers, { cwd = config.root_dir })
  end,
  filetypes = { 'java' },
  root_markers = {
    'settings.gradle',
    'settings.gradle.kts',
    'pom.xml',
    'build.gradle',
    'build.gradle.kts',
    'mvnw',
    'gradlew',
    '.git',
  },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = { maxResults = 20 },
    },
  },
}
