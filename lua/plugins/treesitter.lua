local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"css",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"markdown",
		"php",
		"python",
		"scss",
		"tsx",
		"typescript",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = false },
	},
})
