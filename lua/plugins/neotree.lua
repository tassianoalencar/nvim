vim.pack.add({
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('3') },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

require('neo-tree').setup({})

-- Keymaps
vim.keymap.set('n', '<leader>e', ':Neotree toggle<cr>', { silent = true, desc = 'File Explorer' })
