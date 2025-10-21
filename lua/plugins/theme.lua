vim.pack.add({
  { src = 'https://github.com/AstroNvim/astrotheme' },
  { src = 'https://github.com/navarasu/onedark.nvim' },
})

-- OneDark
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- AstroDark Theme
-- require("astrotheme").setup()
-- vim.cmd('colorscheme astrodark')

-- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
