local COMPLETION_TRIGGER_LEN = 2

vim.lsp.enable({ "lua_ls", "intelephense", "html", "marksman", "tailwindcss", "vtsls", "jdtls" })

vim.diagnostic.config({
  virtual_text = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    vim.lsp.commands["java.apply.workspaceEdit"] = function(command, ctx)
      local edit = command.arguments[1]
      if edit then
        vim.lsp.util.apply_workspace_edit(ctx, "utf-8")
      end
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      local typed = ""

      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        select = false,
      })

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
