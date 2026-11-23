-- Keymaps gerais. Keymaps de plugins ficam em lua/plugins/<nome>.lua
-- e os de LSP em lua/config/lsp.lua
local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
map('n', '<leader>sr', '<cmd>source %<cr>', { desc = 'Source current file' })
map('n', '<leader>si', '<cmd>Inspect<cr>', { desc = 'Inspect highlight under cursor' })
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
map('v', '<leader>n', [[:s/^/\=line('.') - line("'<") + 1 . '. '<CR>]], { silent = true, desc = 'Number lines' })
