local M = {}

M.keymap = vim.keymap.set
M.opts = { silent = true }

function M.init()
	--Remap space as leader key
	M.keymap("", "<Space>", "<Nop>", M.opts)
	vim.g.mapleader = " "

	-- Better window navigation
	M.keymap("n", "<C-h>", "<C-w>h", M.opts)
	M.keymap("n", "<C-j>", "<C-w>j", M.opts)
	M.keymap("n", "<C-k>", "<C-w>k", M.opts)
	M.keymap("n", "<C-l>", "<C-w>l", M.opts)

	-- Resize with arrows
	M.keymap("n", "<S-Up>", ":resize -2<CR>", M.opts)
	M.keymap("n", "<S-Down>", ":resize +2<CR>", M.opts)
	M.keymap("n", "<S-Left>", ":vertical resize -2<CR>", M.opts)
	M.keymap("n", "<S-Right>", ":vertical resize +2<CR>", M.opts)

	-- Navigate buffers
	M.keymap("n", "<S-l>", ":bnext<CR>", M.opts)
	M.keymap("n", "<S-h>", ":bprevious<CR>", M.opts)

	-- Clear highlights
	M.keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", M.opts)

	-- Close buffers
	M.keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", M.opts)

	-- Better paste
	M.keymap("v", "p", '"_dP', M.opts)

	-- Press jk fast to enter
	M.keymap("i", "jk", "<ESC>", M.opts)

	-- Stay in indent mode
	M.keymap("v", "<", "<gv", M.opts)
	M.keymap("v", ">", ">gv", M.opts)

	-- NvimTree
	M.keymap("n", "<leader>tt", ":NvimTreeToggle<CR>", M.opts)

	M.telescope()
	M.comments()
end

function M.telescope()
	M.keymap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', M.opts)
	M.keymap("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>', M.opts)
	M.keymap("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>', M.opts)
	M.keymap("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>', M.opts)
	M.keymap("n", "<leader>fe", '<cmd>lua require("telescope.builtin").diagnostics()<cr>', M.opts)
	M.keymap("n", "<leader>fr", '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>', M.opts)
	M.keymap("n", "<leader>ft", '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<cr>', M.opts)
	M.keymap("n", "<leader>fo", '<cmd>lua require("telescope.builtin").oldfiles()<cr>', M.opts)
end

function M.lsp(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap

	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	keymap(bufnr, "n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
	keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<C-K>", '<cmd>lua require("lsp_signature").signature()<cr>', opts)

	keymap(bufnr, "n", "<leader>ts", ":SymbolsOutline<cr>", opts)
end

function M.comments()
	M.keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", M.opts)
	M.keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
end

return M
