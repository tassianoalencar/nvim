vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap

map.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

map.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

map.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- buffers
map.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

map.set("v", "<", "<gv")
map.set("v", ">", ">gv")

map.set("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hist.is_enabled({0}, {0}))
end, { desc = "Inlay Hints" })
