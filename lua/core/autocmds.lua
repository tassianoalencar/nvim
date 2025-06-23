local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  pattern = '*',
  group =  augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = 'YankHighlight', priority = 10000 }
  end,
})

augroup('_file_opened', { clear = true })
autocmd({ 'BufRead', 'BufWinEnter', 'BufNewFile' }, {
  group = '_file_opened',
  nested = true,
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf }) -- special buffers like telescopes 'prompt', or plugin buffers 'nofile', etc.
    local filename = vim.fn.expand '%'
    if filename ~= '' and buftype == '' then
      vim.api.nvim_del_augroup_by_name '_file_opened'
      vim.cmd 'do User FileOpened'
    end
  end,
})

vim.cmd [[highlight YankHighlight guifg=#000000 guibg=#72FCF3 gui=nocombine]]
