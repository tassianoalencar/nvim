local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {
  'neovim/nvim-lspconfig',
}

M.dependencies = {
  { 'williamboman/mason.nvim', opts = {} },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  { 'j-hui/fidget.nvim', opts = {} },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}

local servers = {
  tailwindcss = {},
  angularls = {},
  intelephense = {},
  html = {},
  cssls = {},
  vtsls = {
    settings = {
      typescript = {
        updateImportsOnFileMove = { enabled = 'always' },
        inlayHints = {
          parameterNames = { enabled = 'all' },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      javascript = {
        updateImportsOnFileMove = { enabled = 'always' },
        inlayHints = {
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      vtsls = {
        enableMoveToFileCodeAction = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        hint = {
          enable = true,
        },
      },
    },
  },
}

M.config = function()
  autocmd('LspAttach', {
    group = augroup('lsp-attach', { clear = true }),
    callback = function(event)
      -- vim.keymap.set('n', '<leader>ca', require('fzf-lua').lsp_code_actions)
      -- vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions)
      -- vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references)
      -- vim.keymap.set('n', 'gI', require('fzf-lua').lsp_implementations)
      -- vim.keymap.set('n', 'gI', require('fzf-lua').lsp_implementations)

      -- lsp_references	References
      -- lsp_definitions	Definitions
      -- lsp_declarations	Declarations
      -- lsp_typedefs	Type Definitions
      -- lsp_implementations	Implementations
      -- lsp_document_symbols	Document Symbols
      -- lsp_workspace_symbols	Workspace Symbols
      -- lsp_live_workspace_symbols	Workspace Symbols (live query)
      -- lsp_incoming_calls	Incoming Calls
      -- lsp_outgoing_calls	Outgoing Calls
      -- lsp_code_actions	Code Actions
      -- lsp_finder	All LSP locations, combined view
      -- diagnostics_document	Document Diagnostics
      -- diagnostics_workspace	Workspace Diagnostics
      -- lsp_document_diagnostics	alias to diagnostics_document
      -- lsp_workspace_diagnostics	alias to diagnostics_workspace

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = augroup('lsp-highlight', { clear = false })

        autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
          end,
        })
      end
    end,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

  local ensure_installed = vim.tbl_keys(servers or {})

  vim.list_extend(ensure_installed, {
    'stylua', -- Used to format Lua code
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }
  require('mason-lspconfig').setup {
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    },
  }
end

return M
