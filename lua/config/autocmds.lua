local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Treesitter highlight em qualquer filetype com parser disponível
autocmd('FileType', {
  group = augroup('user.treesitter', { clear = true }),
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- Mostra o diagnóstico da linha ao parar o cursor
autocmd('CursorHold', {
  group = augroup('user.diagnostic_float', { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      focus = false,
      close_events = { 'CursorMoved', 'CursorMovedI', 'BufLeave', 'InsertEnter' },
    })
  end,
})

-- No quickfix/location list, <CR> abre o item e fecha a lista
autocmd('FileType', {
  group = augroup('user.qf_close', { clear = true }),
  pattern = 'qf',
  callback = function(ev)
    vim.keymap.set('n', '<CR>', function()
      local loclist = vim.fn.win_gettype() == 'loclist'
      local ok, err = pcall(vim.cmd, (loclist and 'll ' or 'cc ') .. vim.fn.line('.'))
      if not ok then
        return vim.notify(err, vim.log.levels.ERROR)
      end
      vim.cmd(loclist and 'lclose' or 'cclose')
    end, { buffer = ev.buf, desc = 'Abrir item e fechar a lista' })
  end,
})
