local global = vim.g
local opt = vim.opt

global.material_style = "deep ocean"

global.mapleader = " "
global.maplocalleader = " "
global.have_nerd_font = true

opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 0 -- so that `` is visible in markdown files

opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.pumheight = 10 -- pop up menu height
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 0 -- always show tabs

opt.smartcase = true -- smart case
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeout = true
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo
opt.updatetime = 300 -- faster completion (4000ms default)
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.tabstop = 4 -- the number of spaces inserted for a tab
opt.cursorline = true -- highlight the current line
opt.laststatus = 3 -- only the last window will always have a status line
opt.showcmd = false -- hide (partial) command in the last line of the screen (for performance)
opt.ruler = false -- hide the line and column number of the cursor position
opt.numberwidth = 4 -- minimal number of columns to use for the line number {default 4}
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = false -- display lines as one long line

opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.fillchars:append({ eob = " " }) -- show empty lines at the end of a buffer as ` ` {default `~`}
opt.shortmess:append("c") -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
opt.whichwrap:append("<,>,[,],h,l") -- keys allowed to move to the previous/next line when the beginning/end of line is reached
opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done

opt.linebreak = true
opt.foldenable = true -- disable folding by default
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "v:lua.vim.treesitter.foldtext()"

opt.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<" -- requried for checking formatting using :set list
opt.diffopt:append("iwhiteall")
opt.background = "light"

-- Function to set unique options based on filetype
local function set_tab_options(filetype, options)
	for option, value in pairs(options) do
		local cmd = string.format("autocmd FileType %s setlocal %s=%s", filetype, option, value)
		vim.cmd(cmd)
	end
end

-- Options overrides for different filetypes
set_tab_options("lua", { tabstop = 2, shiftwidth = 2 })
set_tab_options("markdown", { tabstop = 2, shiftwidth = 2 })

-- vim.cmd([[ colorscheme mago ]])
