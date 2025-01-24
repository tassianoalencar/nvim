local map = vim.keymap.set

-- Move Window
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Move Buffer
map('n', '<S-h>', ':bprev<CR>', { noremap = true, silent = true })
map('n', '<S-l>', ':bnext<CR>', { noremap = true, silent = true })
