local COMPLETION_TRIGGER_LEN = 2

-- Ativa os LSPs que você quiser
vim.lsp.enable({ 'lua_ls', 'intelephense', 'html', 'marksman', 'vtsls' })

-- Diagnósticos visuais
vim.diagnostic.config({
  virtual_text = true,
  underline = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.HINT] = "●",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.WARN] = "●",
    }
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
      { buffer = bufnr, silent = true, noremap = true, desc = 'Goto Definition' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,
      { buffer = bufnr, silent = true, noremap = true, desc = 'Goto References' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
      { buffer = bufnr, silent = true, noremap = true, desc = 'Show Documentation' })
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end,
      { buffer = bufnr, silent = true, noremap = true, desc = 'Code Rename' })
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end,
      { buffer = bufnr, silent = true, noremap = true, desc = 'Code Rename' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
      { buffer = bufnr, silent = true, noremap = true, desc = 'Code Rename' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
      { buffer = bufnr, silent = true, noremap = true, desc = 'Code Action' })

    -- Autocomplete nativo
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        select = false,
      })

      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end, { buffer = bufnr })

      vim.keymap.set('i', '<Down>', function()
        if vim.fn.pumvisible() == 1 then
          return '<C-n>'
        else
          return '<Down>'
        end
      end, { buffer = bufnr, expr = true })

      vim.keymap.set('i', '<Up>', function()
        if vim.fn.pumvisible() == 1 then
          return '<C-p>'
        else
          return '<Up>'
        end
      end, { buffer = bufnr, expr = true })

      vim.keymap.set('i', '<CR>', function()
        if vim.fn.pumvisible() == 1 then
          return '<C-y>'
        else
          return '<CR>'
        end
      end, { buffer = bufnr, expr = true })

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
