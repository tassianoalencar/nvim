local api = vim.api
local keymap = vim.keymap.set

local function enable_foldexpr(bufnr)
  if api.nvim_buf_line_count(bufnr) > 40000 then
    return
  end
  api.nvim_buf_call(bufnr, function()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'

    if vim.g.enable_auto_fold then
      vim.cmd.normal('zx')
    end
  end)
end

local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false
}

M.config = function ()
  require("nvim-treesitter").setup {
    ensure_install = { "lua", "html", "php" },
  }
end

api.nvim_create_autocmd('FileType', {
  callback = function (args)
    if args.match == 'asl' then
      return
    end

    if not pcall(vim.treesitter.start, args.buf) then
      return
    end

    api.nvim_exec_autocmds('User', {pattern = 'ts_attach'})

    enable_foldexpr(args.buf)
  end
})

vim.treesitter.language.register('bash', 'zsh')
vim.treesitter.language.register('verilog', 'systemverilog')

keymap('n', '<leader>ts', function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
  else
    vim.treesitter.start()
  end
end)

return M
