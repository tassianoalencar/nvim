local home = vim.env.HOME
local jdtls_path = home .. "/.local/share/jdtls"
local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local workspace = jdtls_path .. "/workspaces/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

return {
  name = "jdtls",
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "-Xmx2G",
    "-jar", launcher,
    "-configuration", jdtls_path .. "/config_linux",
    "-data", workspace,
  },
  root_markers = {
    'settings.gradle',
    'settings.gradle.kts',
    'pom.xml',
    'build.gradle',
    'mvnw',
    'gradlew',
    'build.gradle',
    'build.gradle.kts',
    '.git',
  },
  filetypes = { "java" },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = { maxResults = 20 },
    },
  },
  -- capabilities = vim.lsp.protocol.make_client_capabilities(),
}
