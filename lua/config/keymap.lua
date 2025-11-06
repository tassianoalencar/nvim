-- keymap
--------------------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set

-- Increase and decrease window size vertically and horizontally
keymap('n', '<C-S-Up>', ':resize +5<CR>', { noremap = true, silent = true })
keymap('n', '<C-S-Down>', ':resize -5<CR>', { noremap = true, silent = true })
keymap('n', '<C-S-Left>', ':vertical resize -5<CR>', { noremap = true, silent = true })
keymap('n', '<C-S-Right>', ':vertical resize +5<CR>', { noremap = true, silent = true })

-- Finds
keymap('n', '<leader>ff', ':Pick files<cr>', { noremap = true, silent = true, desc = 'Find Files' })
keymap('n', '<leader>fb', ':Pick buffers<cr>', { noremap = true, silent = true, desc = 'Find Buffers' })
keymap('n', '<leader>fw', ':Pick grep_live<cr>', { noremap = true, silent = true, desc = 'Find Worlds' })

-- Buffers
keymap('n', '<S-h>', ':bprev<cr>', { noremap = true, silent = true, desc = 'Previous Buffer' })
keymap('n', '<S-l>', ':bnext<cr>', { noremap = true, silent = true, desc = 'Next Buffer' })
keymap('n', '<leader>bd', ':bd<cr>', { noremap = true, silent = true, desc = 'Delete Buffer' })

keymap('n', '<Esc>', ':noh<cr>', { noremap = true, silent = true, desc = 'Clear Highlight' })

keymap('n', '<leader>ssp', ':lua MiniSessions.write("maguh")<cr>', { noremap = true, silent = true, desc = "Save Session to Personal" })
keymap('n', '<leader>srp', ':lua MiniSessions.read("maguh")<cr>', { noremap = true, silent = true, desc = "Restore Session to Personal" })
keymap('n', '<leader>ssi', ':lua MiniSessions.write("informata")<cr>', { noremap = true, silent = true, desc = "Save Session to Informata" })
keymap('n', '<leader>sri', ':lua MiniSessions.read("informata")<cr>', { noremap = true, silent = true, desc = "Restore Session to Informata" })

-- Lsp keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf

    keymap('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
    keymap('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover', silent = true })
    keymap('n', '<leader>cf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Code Format' })
    keymap('i', '<C-Space>', vim.lsp.completion.get)
  end
})
