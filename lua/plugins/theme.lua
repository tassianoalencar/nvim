return {
  'AstroNvim/astrotheme',
  lazy = false, -- disable lazy loading
  priority = 10000, -- load AstroUI first
  config = function()
    require('astrotheme').setup {}

    vim.cmd 'colorscheme astrodark'
  end,
}
