vim.pack.add({
  { src = "https://github.com/supermaven-inc/supermaven-nvim" }
})

require("supermaven-nvim").setup({})

-- Ativa os LSPs que você quiser
vim.lsp.enable({ 'lua_ls', 'intelephense', 'html', 'marksman', 'vtsls' })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    local keymap = vim.keymap.set

    if client ~= nil and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true
      })

      -- vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
      --   convert = function(item)
      --     local abbr = item.label
      --     abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
      --     abbr = abbr:match("[%w_.]+.*") or abbr
      --     abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr
      --
      --     local menu = item.detail or ""
      --     menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu
      --
      --     return { abbr = abbr, menu = menu }
      --   end,
      -- })
      --

      keymap("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
      keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
      keymap("n", "gD", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
      keymap("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references" })
      keymap("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
      keymap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
      keymap("n", "<leader>f", vim.lsp.buf.format, { buffer = bufnr, desc = "Format" })
      keymap("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
    end
  end,
})
