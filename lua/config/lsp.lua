vim.pack.add({
  { src = "https://github.com/supermaven-inc/supermaven-nvim" }
})

require("supermaven-nvim").setup({})

local COMPLETION_TRIGGER_LEN = 2

-- Ativa os LSPs que você quiser
vim.lsp.enable({ 'lua_ls', 'intelephense', 'html', 'marksman', 'tailwindcss' })

vim.diagnostic.config({
  virtual_text = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    -- Autocomplete nativo
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        select = false,
      })


      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
      -- set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to implementation' })
      -- set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Code Hover' })
      -- set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Code References' })
      -- set('n', '<leader>cf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Code Format' })
      -- set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Code Rename' })
      -- set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Rename' })

      local typed = ""

      vim.api.nvim_create_autocmd("InsertCharPre", {
        buffer = bufnr,
        callback = function()
          local ch = vim.v.char or ""
          if ch:match("%w") then
            typed = typed .. ch
          else
            typed = ""
          end

          if #typed >= COMPLETION_TRIGGER_LEN and vim.fn.pumvisible() ~= 1 then
            vim.schedule(function()
              vim.lsp.completion.get()
            end)
            typed = ""
          end
        end,
      })

      vim.api.nvim_create_autocmd("InsertLeave", {
        buffer = bufnr,
        callback = function() typed = "" end,
      })
    end
  end,
})
