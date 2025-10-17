vim.pack.add({
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/AstroNvim/astrotheme' }
})

-- Tokyo Night Theme
-- vim.cmd('colorscheme tokyonight-night')

-- AstroDark Theme
require("astrotheme").setup()
vim.cmd('colorscheme astrodark')
