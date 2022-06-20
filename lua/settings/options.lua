-- lua/settings/options.lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoread = true
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.hidden = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.laststatus = 3
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 15
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.updatetime = 300
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Persistent undo
vim.opt['undofile'] = true
vim.opt['undodir'] = os.getenv( 'HOME' )..'/.cache/nvim/undo'
vim.opt['undolevels'] = 1000
vim.opt['undoreload'] = 10000

-- Stop comments on newline
vim.cmd('autocmd BufWinEnter * :set formatoptions-=c formatoptions-=r formatoptions-=o')

vim.cmd('command CDD cd %:p:h')
