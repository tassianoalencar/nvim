vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.clipboard:append("unnamedplus") ------ use system clipboard as default register
opt.tabstop        = 2 ------------------- 2 spaces for tabs (prettier default)
opt.shiftwidth     = 2 ------------------- 2 spaces for indent width
opt.expandtab      = true ---------------- expand tab for space
opt.autoindent     = true ---------------- copy indent from current line when start new one
opt.ignorecase     = true ---------------- ignore case when searching
opt.smartcase      = true ---------------- if you include mixed case in your search, assumes you want case-sensitive
opt.termguicolors  = true
opt.background     = "dark" -------------- colorscheme that can be light or dark will be made dark
opt.signcolumn     = "yes"  -------------- show sign column so that doesn't shift
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.wrap           = false
opt.backspace      = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.splitright     = true ---------------- split vertical window to the right
opt.splitbelow     = true ---------------- split horizontal window to the bottom
opt.pumheight      = 10 ------------------ Max height for pum  
opt.backup         = false
opt.writebackup    = false
opt.swapfile       = false
