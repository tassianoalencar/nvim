-- lua/settings/keymaps.lua
-- Modes
--   normal_mode       = "n",
--   insert_mode       = "i",
--   visual_mode       = "v",
--   visual_block_mode = "x",
--   term_mode         = "t",
--   command_mode      = "c",
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Buffers
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<leader>bq", "<cmd>lua require('close_buffers').delete({ type = 'this' })<cr>", opts)
keymap("n", "<leader>bc", "<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true })<cr>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Telescope
keymap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
keymap("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
keymap("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
keymap("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)
keymap("n", "<leader>fe", '<cmd>lua require("telescope.builtin").diagnostics()<cr>', opts)
keymap("n", "<leader>fr", '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>', opts)
keymap("n", "<leader>ft", '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<cr>', opts)
keymap("n", "<leader>fo", '<cmd>lua require("telescope.builtin").oldfiles()<cr>', opts)

-- Nvim Tree
keymap("n", "<leader>tt", "<cmd>:NvimTreeToggle<cr>", opts)

-- Lspsaga
keymap("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
keymap("n", "<leader>sd", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
