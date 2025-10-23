-- mini plugins
--------------------------------------------------------------------------------
vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
})

require("mini.starter").setup()
require("mini.pick").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.tabline").setup()
require("mini.indentscope").setup()
require("mini.ai").setup()

require("mini.statusline").setup({
  use_icons = false
})

require("nvim-autopairs").setup({})
