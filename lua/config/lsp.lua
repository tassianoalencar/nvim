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

--- Range (formato de vim.lsp.buf.code_action) cobrindo a linha do cursor,
--- ou nil se a linha não tiver diagnósticos. Por padrão o Neovim só envia ao
--- servidor os diagnósticos que estão exatamente sob o cursor; usando a linha
--- inteira, os quick fixes aparecem com o cursor em qualquer ponto dela.
local function line_diagnostic_range()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  if #vim.diagnostic.get(0, { lnum = row - 1 }) == 0 then
    return nil
  end
  local len = #vim.api.nvim_get_current_line()
  return { start = { row, 0 }, ['end'] = { row, math.max(len - 1, 0) } }
end

--- Code actions; no modo normal inclui todos os diagnósticos da linha.
local function code_action()
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'v' or mode == 'V' then
    return vim.lsp.buf.code_action()
  end
  vim.lsp.buf.code_action({ range = line_diagnostic_range() })
end

--- Quick fix: só ações que corrigem os diagnósticos da linha.
--- Se houver apenas uma, aplica direto; se a linha não tiver problema,
--- pula para o próximo diagnóstico primeiro.
local function quickfix()
  local range = line_diagnostic_range()
  if not range then
    if not vim.diagnostic.jump({ count = 1 }) then
      return vim.notify('Nenhum diagnóstico no buffer', vim.log.levels.INFO)
    end
    range = line_diagnostic_range()
  end
  vim.lsp.buf.code_action({
    range = range,
    context = { only = { 'quickfix' } },
    apply = true,
  })
end

--- Go to definition: remove locais duplicados (alguns servidores, como o
--- intelephense, devolvem o mesmo local mais de uma vez). Com um único
--- resultado pula direto; com vários abre o quickfix.
local function goto_definition()
  vim.lsp.buf.definition({
    on_list = function(opts)
      local seen, items = {}, {}
      for _, item in ipairs(opts.items) do
        local key = ('%s:%d:%d'):format(item.filename, item.lnum, item.col)
        if not seen[key] then
          seen[key] = true
          table.insert(items, item)
        end
      end
      vim.fn.setqflist({}, ' ', { title = opts.title, items = items })
      vim.cmd(#items == 1 and 'cfirst' or 'botright copen')
    end,
  })
end

local function setup_keymaps(buf)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
  end

  map('n', 'gd', goto_definition, 'Go to definition')
  map('n', '<leader>cf', vim.lsp.buf.format, 'Code format')
  map('n', '<leader>cr', vim.lsp.buf.rename, 'Code rename')
  map({ 'n', 'x' }, '<leader>ca', code_action, 'Code actions')
  map('n', '<leader>cq', quickfix, 'Quick fix diagnostic')
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
