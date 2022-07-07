local opt = vim.opt
local cmd = vim.cmd
local indent = 4

cmd([[
  filetype plugin indent on
]])

-- misc
opt.backspace = { "eol", "start", "indent" }
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"

-- indention
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

-- search
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

-- ui
opt.cursorline = true
opt.laststatus = 2
opt.lazyredraw = true
opt.list = false
opt.listchars = {
	tab = "❘-",
	trail = "·",
	lead = "·",
	extends = "»",
	precedes = "«",
	nbsp = "×",
}
opt.mouse = "a"
opt.number = true
opt.rnu = true
opt.scrolloff = 18
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = "yes"
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.wrap = false

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- autocomplete
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess = opt.shortmess + { c = true }

-- perfomance
opt.redrawtime = 1500
opt.timeoutlen = 250
opt.ttimeoutlen = 10
opt.updatetime = 100

-- theme
opt.termguicolors = true

--vim.opt.number = true
--vim.opt.relativenumber = true
--vim.opt.cmdheight = 1
--vim.opt.mouse = "a"
--vim.opt.clipboard = "unnamedplus"
--vim.opt.hlsearch = true
--vim.opt.fileencoding = "utf-8"
--vim.opt.ignorecase = true
--vim.opt.smartcase = true
--vim.opt.smartindent = true
--vim.opt.splitbelow = true
--vim.opt.splitright = true
--vim.opt.updatetime = 200
--vim.opt.expandtab = true
--vim.opt.shiftwidth = 4
--vim.opt.tabstop = 4
--vim.opt.cursorline = true
--vim.opt.numberwidth = 2
--vim.opt.signcolumn = "yes"
--vim.opt.wrap = false
--vim.opt.scrolloff = 15
--vim.opt.sidescrolloff = 15
--vim.opt.completeopt = { "menu", "menuone", "noselect" }
--vim.opt.shortmess = vim.opt.shortmess + { c = true }
--vim.opt.backspace = { "eol", "start", "indent" }
--vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
--vim.opt.syntax = "enable"
