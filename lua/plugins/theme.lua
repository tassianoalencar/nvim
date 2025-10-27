vim.pack.add({
  { src = "https://github.com/tiagovla/tokyodark.nvim" },
})

require("tokyodark").setup({
  transparent_background = false,                                        -- set background to transparent
  gamma = 1,                                                          -- adjust the brightness of the theme
  styles = {
    comments = { italic = false },                                       -- style for comments
    keywords = { italic = false },                                       -- style for keywords
    identifiers = { italic = false },                                    -- style for identifiers
    functions = {},                                                      -- style for functions
    variables = {},                                                      -- style for variables
  },
})

vim.cmd("colorscheme tokyodark")
