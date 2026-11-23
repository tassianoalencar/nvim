-- ==========================================================================
-- Ponto de entrada. Cada parte da config vive em lua/config/ e lua/plugins/
-- ==========================================================================
vim.g.mapleader = ' ' -- antes de qualquer keymap

require('config.options')
require('config.pack')     -- instala/carrega plugins e roda lua/plugins/*
require('config.keymaps')
require('config.autocmds')
require('config.lsp')
