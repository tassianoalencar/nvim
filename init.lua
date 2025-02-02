require 'core.options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = {
    { import = 'plugins.lsp' },
    { import = 'plugins.dap' },
    { import = 'plugins' },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false, -- get a notification when changes are found
  },
}

require 'core.mappings'
require 'core.autocmds'
require 'core.filetype'
