-- options
--------------------------------------------------------------------------------
local opt = vim.opt
local o = vim.o

o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"
o.clipboard = "unnamedplus"
o.cursorline = true
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.ignorecase = true
o.smartcase = true
o.number = true
o.relativenumber = true
o.numberwidth = 6
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true
o.updatetime = 250
opt.fillchars = { eob = " " } -- Remove ~ on line empty
opt.pumblend = 10
opt.pumheight = 10
