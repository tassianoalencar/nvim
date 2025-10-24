vim.pack.add({
  { src = "https://github.com/supermaven-inc/supermaven-nvim" }
})
require("supermaven-nvim").setup({})


local COMPLETION_TRIGGER_LEN = 2

-- Ativa os LSPs que você quiser
vim.lsp.enable({ 'lua_ls', 'intelephense', 'html', 'marksman', 'vtsls' })

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

      -- vim.keymap.set('i', '<CR>', function()
      --   if vim.fn.pumvisible() == 1 then
      --     return '<C-y>'
      --   else
      --     return '<CR>'
      --   end
      -- end, { buffer = bufnr, expr = true })

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
