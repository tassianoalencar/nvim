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
  custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
  custom_palette = {} or function(palette) return {} end,                -- extend palette
  terminal_colors = true,                                                -- enable terminal colors
})

vim.cmd("colorscheme tokyodark")

-- set(0, "Normal", { fg = palette.fg, bg = palette.bg0 })
