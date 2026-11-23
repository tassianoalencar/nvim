-- Fonte única dos servidores LSP.
-- Chave: nome usado em lsp/<nome>.lua e vim.lsp.enable()
-- Valor: nome do pacote no Mason (:Mason para buscar)
local M = {}

M.servers = {
  -- Lua
  lua_ls = 'lua-language-server',
  -- Web
  vtsls = 'vtsls',
  html = 'html-lsp',
  cssls = 'css-lsp',
  jsonls = 'json-lsp',
  tailwindcss = 'tailwindcss-language-server',
  -- PHP
  intelephense = 'intelephense',
  -- Python
  pyright = 'pyright',
  ruff = 'ruff',
  -- Shell
  bashls = 'bash-language-server',
  -- Markdown
  marksman = 'marksman',
  -- Rust
  rust_analyzer = 'rust-analyzer',
  -- Java (requer Java 21+ no sistema)
  jdtls = 'jdtls',
}

-- Ferramentas extras que não são LSP (formatters, linters...)
M.tools = {
  'stylua',
}

local function packages()
  local list = vim.list_extend(vim.tbl_values(M.servers), M.tools)
  table.sort(list)
  return list
end

--- Pacotes ainda não instalados (checagem local, não precisa do registry).
function M.missing()
  local registry = require('mason-registry')
  return vim.tbl_filter(function(name)
    return not registry.is_installed(name)
  end, packages())
end

--- Instala tudo que falta via Mason.
--- @param on_done? fun(failed: string[])
function M.install(on_done)
  local registry = require('mason-registry')
  on_done = on_done or function() end

  registry.refresh(vim.schedule_wrap(function()
    local pending, failed = 0, {}

    local function finish()
      -- Anexa os LSPs recém-instalados aos buffers já abertos
      vim.cmd.doautoall('nvim.lsp.enable FileType')
      if #failed == 0 then
        vim.notify('[servers] Tudo instalado ✅')
      else
        vim.notify('[servers] Falhou: ' .. table.concat(failed, ', '), vim.log.levels.ERROR)
      end
      on_done(failed)
    end

    for _, name in ipairs(packages()) do
      local ok, pkg = pcall(registry.get_package, name)
      if not ok then
        table.insert(failed, name .. ' (não existe no registry)')
      elseif not pkg:is_installed() and not pkg:is_installing() then
        pending = pending + 1
        vim.notify('[servers] Instalando ' .. name .. '...')
        pkg:install({}, vim.schedule_wrap(function(success, err)
          if success then
            vim.notify('[servers] ' .. name .. ' instalado')
          else
            table.insert(failed, name .. ' (' .. tostring(err) .. ')')
          end
          pending = pending - 1
          if pending == 0 then finish() end
        end))
      end
    end

    if pending == 0 then finish() end
  end))
end

--- Versão bloqueante para uso headless (install.sh). Sai com código 1 se algo falhar.
function M.install_sync()
  local done, failed = false, {}
  M.install(function(f)
    failed, done = f, true
  end)

  if not vim.wait(15 * 60 * 1000, function() return done end, 500) then
    io.stderr:write('[servers] Timeout\n')
    vim.cmd('cquit 1')
  end
  vim.cmd(#failed == 0 and 'qall!' or 'cquit 1')
end

vim.api.nvim_create_user_command('LspInstallAll', function() M.install() end, {
  desc = 'Instala via Mason todos os LSPs/ferramentas de lua/config/servers.lua',
})

-- Ao abrir o Neovim, instala automaticamente o que estiver faltando.
-- (install.sh usa g:bootstrap e chama install_sync por conta própria)
if not vim.g.bootstrap then
  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('user.servers', { clear = true }),
    once = true,
    callback = function()
      local ok, missing = pcall(M.missing)
      if ok and #missing > 0 then
        vim.notify('[servers] Faltando: ' .. table.concat(missing, ', ') .. '. Instalando...')
        M.install()
      end
    end,
  })
end

return M
