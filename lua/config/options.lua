-- options
--------------------------------------------------------------------------------
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.splitkeep = "screen"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 400
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.fillchars = { eob = " " }
vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup" }
vim.opt.shortmess:append("c")
vim.opt.pumborder = "double"
vim.opt.pumblend = 10
vim.opt.pumheight = 10

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldminlines = 1
