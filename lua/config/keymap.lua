-- keymap
--------------------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set

-- Move arround windows
keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Increase and decrease window size vertically and horizontally
keymap('n', '<C-S-Up>', ':resize +5<CR>', { noremap = true, silent = true })
keymap('n', '<C-S-Down>', ':resize -5<CR>', { noremap = true, silent = true })
keymap('n', '<C-S-Left>', ':vertical resize -5<CR>', { noremap = true, silent = true })
keymap('n', '<C-S-Right>', ':vertical resize +5<CR>', { noremap = true, silent = true })

-- Update and Source
keymap('n', '<leader>uo', ':update<cr> :source<cr>', { noremap = true, silent = true, desc = 'Update & Source' })

-- Finds
keymap('n', '<leader>ff', ':Pick files<cr>', { noremap = true, silent = true, desc = 'Find Files' })
keymap('n', '<leader>fb', ':Pick files<cr>', { noremap = true, silent = true, desc = 'Find Buffers' })

