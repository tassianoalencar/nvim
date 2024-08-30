return {
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	opts = {
		numhl = true,
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 500,
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end)

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end)

			-- Actions
			map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Git stage hunk" })
			map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Git reset hunk" })
			map("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Git stage hunk" })
			map("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Git reset hunk" })
			map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Git stage buffer" })
			map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Git undo stage hunk" })
			map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Git reset buffer" })
			map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git preview hunk" })
			map("n", "<leader>gb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "Git blame_line" })
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "" })
			map("n", "<leader>hd", gitsigns.diffthis, { desc = "" })
			map("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { desc = "" })
			map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "" })

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	},
}
