local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = api.nvim_create_augroup("alencar_yanking", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

api.nvim_create_autocmd("VimEnter", {
	desc = "Update automatic plugins",
	group = api.nvim_create_augroup("alencar_update", { clear = true }),
	callback = function()
		require("lazy").update({ show = false })
	end,
})

api.nvim_create_autocmd("BufEnter", {
	desc = "Disable comment on linebreak",
	group = api.nvim_create_augroup("alencar_comment", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
