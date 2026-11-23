-- ==========================================================================
-- LSP nativo. Config de cada servidor: lsp/<nome>.lua
-- Lista de servidores/pacotes do Mason: lua/config/servers.lua
-- ==========================================================================
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.lsp.enable(vim.tbl_keys(require('config.servers').servers))
vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { source = true },
})

--- Autocompletar nativo: abre o menu após 2 caracteres de palavra.
--- Um único grupo por buffer, mesmo com vários servidores anexados.
local function setup_completion(client, buf)
  vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })

  local group = augroup('user.lsp.completion.' .. buf, { clear = true })
  local typed = 0

  autocmd('InsertCharPre', {
    group = group,
    buffer = buf,
    callback = function()
      typed = vim.v.char:match('%w') and typed + 1 or 0
      if typed >= 2 and vim.fn.pumvisible() ~= 1 then
        typed = 0
        vim.schedule(vim.lsp.completion.get)
      end
    end,
  })

  autocmd('InsertLeave', {
    group = group,
    buffer = buf,
    callback = function() typed = 0 end,
  })
end

local function setup_keymaps(buf)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
  end

  map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
  map('n', '<leader>cf', vim.lsp.buf.format, 'Code format')
  map('n', '<leader>cr', vim.lsp.buf.rename, 'Code rename')
  map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code actions')
  map('i', '<C-Space>', vim.lsp.completion.get, 'Trigger completion')
end

autocmd('LspAttach', {
  group = augroup('user.lsp', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      setup_completion(client, ev.buf)
    end
    setup_keymaps(ev.buf)
  end,
})
