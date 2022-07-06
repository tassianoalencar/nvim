local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"html",
	"tsserver",
	"intelephense",
	"cssls",
}

lsp_installer.setup({
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	if server == "intelephense" then
		local intelephense_config = {
			init_options = {
				embeddedLanguages = { css = true, javascript = true },
			},
		}

		opts = vim.tbl_deep_extend("force", intelephense_config, opts)
	end

	lspconfig[server].setup(opts)
end
