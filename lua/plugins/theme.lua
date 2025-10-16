vim.pack.add({
  { src = 'https://github.com/projekt0n/github-nvim-theme' }
})

require('github-theme').setup({})

vim.cmd('colorscheme github_dark_default')
vim.cmd(':hi statusline guibg=#161b22 guifg=#ffffff')
vim.cmd(':hi CursorLine guibg=#161b22')
