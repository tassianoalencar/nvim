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
