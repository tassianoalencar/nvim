local keymap = vim.keymap.set

-- Move Window
keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Increase and decrease window size vertically and horizontally
keymap('n', '<C-Up>', ':resize +5<CR>', { noremap = true, silent = true })
keymap('n', '<C-Down>', ':resize -5<CR>', { noremap = true, silent = true })
keymap('n', '<C-Left>', ':vertical resize -5<CR>', { noremap = true, silent = true })
keymap('n', '<C-Right>', ':vertical resize +5<CR>', { noremap = true, silent = true })

-- Rest plugin
keymap('n', '<leader>rr', ':Rest run<CR>', { noremap = true, silent = true })


