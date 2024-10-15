local keymap = vim.keymap.set

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Resize windows with Ctrl+Shift+Arrow
keymap("n", "<C-S-Up>", "<C-w>+", { desc = "Resize window up" })
keymap("n", "<C-S-Down>", "<C-w>-", { desc = "Resize window down" })
keymap("n", "<C-S-Left>", "<C-w><", { desc = "Resize window left" })
keymap("n", "<C-S-Right>", "<C-w>>", { desc = "Resize window right" })
