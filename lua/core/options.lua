vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.synmaxcol = 500 -- disable "set syntax" for large files for better performance
vim.opt.smartindent = true -- smartly indent new lines
vim.opt.breakindent = true -- keep same indentation after break
vim.opt.autowrite = true -- Enable auto write
vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.formatoptions = 'jcroqlnt' -- tcqj
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = 'nosplit' -- preview incremental substitute
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.pumblend = 10 -- Pop-up blend
vim.opt.pumheight = 10 -- Maximum number of entries in a pop-up
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shortmess:append { W = true, I = true, c = true, C = true }
vim.opt.showmode = false -- Don't show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spell = false
vim.opt.spelllang = 'pt_br,en'
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap
vim.opt.cmdheight = 0

vim.opt.laststatus = 3
vim.opt.nrformats = 'bin,hex,alpha,octal,'

-- folding
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = 'manual' -- for treesitter / lsp folding, the rest of ufo gets used

vim.o.fillchars = "eob: "

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- put :messages in a new buffer
vim.api.nvim_command 'command! Messages enew | execute "redir @a" | silent messages | redir END | normal! "ap'

---@type rest.Opts
vim.g.rest_nvim = {}
