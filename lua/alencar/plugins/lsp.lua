local api = vim.api

local function lsp_show_diagnostics()
	vim.diagnostic.open_float({ border = "single" })
end

local servers = {
	pyright = {},
	tsserver = {},
	intelephense = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ensure_installed = vim.tbl_keys(servers or {})

local M = {
	"neovim/nvim-lspconfig",
}

M.dependencies = {
	{ "williamboman/mason.nvim", config = true },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "j-hui/fidget.nvim", opts = {} },
	{ "hrsh7th/cmp-nvim-lsp" },
}

-- NOTE :help lsp-vs-treesitter
M.config = function()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	require("mason").setup()

	vim.list_extend(ensure_installed, {
		"stylua", -- Used to format Lua code
	})

	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	local _border = "single"

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = _border,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = _border,
	})

	vim.diagnostic.config({
		float = { border = _border },
	})

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

api.nvim_create_autocmd("LspAttach", {
	group = api.nvim_create_augroup("alencar-group", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local builtin = require("telescope.builtin")

		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>cd", lsp_show_diagnostics, opts)

		map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
		map("gr", builtin.lsp_references, "[G]oto [R]eferences")
		map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("alencar-lsp-highlight", { clear = false })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

return M
