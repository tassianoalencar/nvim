vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.clipboard:append("unnamedplus")
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.pumheight = 10
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Fold
opt.foldmethod = "expr"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 4
