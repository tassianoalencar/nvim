local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end

require("settings.options")
require("settings.keymaps")
require("settings.plugins")
require("settings.colorscheme")
require("settings.lsp")
require("settings.cmp")
require("settings.treesitter")
require("settings.autopairs")
require("settings.nvimtree")
require("settings.telescope")
require("settings.illuminate")
require("settings.autocmd")
require("settings.lualine")
require("settings.bufferline")
require("settings.gitsigns")
require("settings.lspsaga")
