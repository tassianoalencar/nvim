local M = {
  'akinsho/bufferline.nvim',
}

M.version = '*'

M.dependencies = 'nvim-tree/nvim-web-devicons'

M.config = function()
  require('bufferline').setup {}

  vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Buffer line cycle next' })
  vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Buffer line cycle previous' })
  vim.keymap.set('n', '<S-k>', ':BufferLineMovePrev<CR>', { desc = 'Buffer line move previous' })
  vim.keymap.set('n', '<S-j>', ':BufferLineMoveNext<CR>', { desc = 'Buffer line move next' })
  vim.keymap.set('n', '<leader>b', ':BufferLinePick<CR>', { desc = 'Buffer line pick' })
  vim.keymap.set('n', '<leader>bd', ':BufferLinePickClose<CR>', { desc = 'Buffer line pick close' })

  -- Close buffer
  vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>', { desc = 'Buffer line pick close' })

  vim.keymap.set('n', '<leader>b1', ':BufferLineGoToBuffer 1<CR>', { desc = 'Buffer line go to buffer 1' })
  vim.keymap.set('n', '<leader>b2', ':BufferLineGoToBuffer 2<CR>', { desc = 'Buffer line go to buffer 2' })
  vim.keymap.set('n', '<leader>b3', ':BufferLineGoToBuffer 3<CR>', { desc = 'Buffer line go to buffer 3' })
  vim.keymap.set('n', '<leader>b4', ':BufferLineGoToBuffer 4<CR>', { desc = 'Buffer line go to buffer 4' })
  vim.keymap.set('n', '<leader>b5', ':BufferLineGoToBuffer 5<CR>', { desc = 'Buffer line go to buffer 5' })
  vim.keymap.set('n', '<leader>b6', ':BufferLineGoToBuffer 6<CR>', { desc = 'Buffer line go to buffer 6' })
  vim.keymap.set('n', '<leader>b7', ':BufferLineGoToBuffer 7<CR>', { desc = 'Buffer line go to buffer 7' })
  vim.keymap.set('n', '<leader>b8', ':BufferLineGoToBuffer 8<CR>', { desc = 'Buffer line go to buffer 8' })
  vim.keymap.set('n', '<leader>b9', ':BufferLineGoToBuffer 9<CR>', { desc = 'Buffer line go to buffer 9' })
  vim.keymap.set('n', '<leader>b0', ':BufferLineGoToBuffer -1<CR>', { desc = 'Buffer line go to buffer -1' })
end

return M
