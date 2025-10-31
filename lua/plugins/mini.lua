-- mini plugins
--------------------------------------------------------------------------------
vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
})

require("mini.pick").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.tabline").setup()
require("mini.ai").setup()
require("mini.extra").setup()
require("mini.statusline").setup()
require("mini.comment").setup()
require("mini.sessions").setup()

require("mini.indentscope").setup({
  symbol = '|',
})

require("nvim-autopairs").setup({})

