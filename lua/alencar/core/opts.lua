	local global          = vim.g
local opt             = vim.opt

global.mapleader      = ' '
global.maplocalleader = ' '
global.have_nerd_font = false

-- Agenda a definição de sincronização para após UiEnter
-- TODO: Verificar se vale a pena manter isso
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

opt.number         = true
opt.relativenumber = true
opt.mouse          = 'a'
opt.showmode       = false
opt.breakindent    = true
opt.undofile       = true
opt.ignorecase     = true
opt.smartcase      = true
opt.signcolumn     = 'yes'
opt.updatetime     = 250
opt.timeoutlen     = 300
opt.splitright     = true
opt.splitbelow     = true
opt.list           = true
opt.inccommand     = 'split'
opt.cursorline     = true
opt.scrolloff      = 10
opt.listchars      = { tab = '» ', trail = '·', nbsp = '␣' }
