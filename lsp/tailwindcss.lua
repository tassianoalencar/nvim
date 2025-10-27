-- Verifica se o tailwindcss-language-server está instalado
local function ensure_tailwind_lsp()
  local lsp_name = "tailwindcss-language-server"

  -- Checa se o executável está disponível no PATH
  if vim.fn.executable(lsp_name) == 1 then
    return true
  end

  -- Caso contrário, tenta instalar via npm
  vim.notify("Instalando TailwindCSS LSP via npm...", vim.log.levels.INFO)
  local install_cmd = "npm install -g @tailwindcss/language-server"
  local result = os.execute(install_cmd)

  if result == 0 then
    vim.notify("TailwindCSS LSP instalado com sucesso ✅", vim.log.levels.INFO)
    return true
  else
    vim.notify("Falha ao instalar TailwindCSS LSP ❌ — verifique o npm.", vim.log.levels.ERROR)
    return false
  end
end

-- Executa a verificação/instalação
ensure_tailwind_lsp()

---@type vim.lsp.Config
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "ejs",
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
    "package.json",
    "node_modules",
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      includeLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        htmlangular = "html",
        templ = "html",
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
}
