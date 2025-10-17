vim.pack.add({
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/akinsho/git-conflict.nvim'
})

require('git-conflict').setup()

vim.keymap.set('n', '<leader>gcc', '<Plug>(git-conflict-ours)', { silent = true, desc = 'Git Conflict Current'})
vim.keymap.set('n', '<leader>gci', '<Plug>(git-conflict-theirs)', { silent = true, desc = 'Git Conflict Incoming'})
vim.keymap.set('n', '<leader>gcb', '<Plug>(git-conflict-both)', { silent = true, desc = 'Git Conflict Both'})
vim.keymap.set('n', '<leader>gcN', '<Plug>(git-conflict-none)', { silent = true, desc = 'Git Conflict None'})
vim.keymap.set('n', '<leader>gcn', '<Plug>(git-conflict-prev-conflict)', { silent = true, desc = 'Git Conflict Next'})
vim.keymap.set('n', '<leader>gcp', '<Plug>(git-conflict-next-conflict)', { silent = true, desc = 'Git Conflict Prev'})
