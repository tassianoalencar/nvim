local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = { "lua", "vim", "html", "php", "phpdoc", "scss", "javascript", "jsdoc", "json" },
	highlight = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true },
})
