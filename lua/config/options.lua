local opt = vim.opt

-- netrw desativado (usamos nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Interface
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.scrolloff = 8
opt.wrap = false
opt.cmdheight = 0
opt.pumheight = 10
opt.splitbelow = true
opt.splitright = true
vim.o.winborder = 'double'

-- Indentação (por linguagem em ftplugin/)
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = -1 -- segue o shiftwidth
opt.autoindent = true
opt.smartindent = true

-- Folds via treesitter
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99

-- Busca
opt.ignorecase = true
opt.smartcase = true

-- Edição
opt.undofile = true
opt.updatetime = 300
opt.completeopt = { 'fuzzy', 'menu', 'menuone', 'noinsert', 'popup' }

-- Clipboard agendado para não atrasar o startup
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)
