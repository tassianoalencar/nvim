local M = {
  'kevinhwang91/nvim-ufo'
}

M.dependencies = {
  { 'kevinhwang91/promise-async' }
}

M.config = function ()
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

  require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
  })
end

return M
