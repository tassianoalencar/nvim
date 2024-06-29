local M = {}

M.augroup = function(name)
  return vim.api.nvim_create_augroup("tassiano_" .. name, { clear = true })
end

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.create_undo()
  if vim.api.nvim_get_mode().mode == "i" then
    vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
  end
end

M.cmp_confirm = function(opts)
  local cmp = require("cmp")

  opts = vim.tbl_extend("force", {
    select = true,
    behavior = cmp.ConfirmBehavior.Insert,
  }, opts or {})

  return function(fallback)
    if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
      M.create_undo();

      if cmp.confirm(opts) then
        return
      end
    end

    return fallback()
  end
end

return M
