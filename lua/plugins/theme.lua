return {
  'navarasu/onedark.nvim',
  config = function()
    require('onedark').setup {
      style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    }

    require('onedark').load()

    vim.cmd 'colorscheme onedark'
  end,
}

-- return {
--   'AstroNvim/astrotheme',
--   lazy = false, -- disable lazy loading
--   priority = 10000, -- load AstroUI first
--   config = function()
--     require('astrotheme').setup {}
--
--     vim.cmd 'colorscheme astrodark'
--   end,
-- }
