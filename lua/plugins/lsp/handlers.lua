local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local config = require("core.config")
local keymaps = require("core.keymaps")

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		Error = config.icons.error,
		Warn = config.icons.warn,
		Hint = config.icons.hint,
		Info = config.icons.info,
	}

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = config.border,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = config.border,
	})

	vim.diagnostic.config({
		virtual_text = {
            enabled = false,
			prefix = config.icons.prefix,
		},
	})
end

M.lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

M.augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = M.augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = M.augroup,
			buffer = bufnr,
			callback = function()
				M.lsp_formatting(bufnr)
			end,
		})
	end

	keymaps.lsp(bufnr)
end

return M
