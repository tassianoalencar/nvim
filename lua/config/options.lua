-- options
--------------------------------------------------------------------------------
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.splitkeep = "screen"
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.relativenumber = true
-- vim.o.numberwidth = 6
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeoutlen = 400
vim.o.undofile = true
vim.o.updatetime = 250
vim.opt.fillchars = { eob = " " }
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup" }
vim.opt.shortmess:append("c")

-- Fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldminlines = 1
