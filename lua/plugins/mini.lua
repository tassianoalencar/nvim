-- mini plugins
--------------------------------------------------------------------------------
vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim' },
})

require('mini.starter').setup()
require('mini.pick').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.diff').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.tabline').setup()
require('mini.indentscope').setup()

require('mini.clue').setup({
  window = {
    delay = 200
  },
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
  },
  clues = {
    { mode = 'n', keys = '<Leader>c', desc = '+Code' },
    { mode = 'n', keys = '<Leader>f', desc = '+Find' },
    { mode = 'n', keys = '<Leader>u', desc = '+Utils' },
  },
})

