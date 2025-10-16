vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",            version = "master" },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  { src = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' },
  { src = 'https://github.com/chrisgrieser/nvim-various-textobjs' }
})

local disable_func = function(lang, buf)
  local max_line_width = 500

  -- Check first line width
  local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
  if first_line and #first_line > max_line_width then
    return true
  end
end

require("various-textobjs").setup({
  keymaps = {
    useDefaults = true
  }
})

require("nvim-treesitter.configs").setup({
  additional_vim_regex_highlighting = false,
  ensure_installed = { 'lua', 'tsx', 'typescript', 'vimdoc', 'vim', 'regex', 'bash', 'markdown_inline', 'markdown', 'angular', 'html', 'css', 'scss', 'javascript', 'json', 'yaml', 'toml', 'python', 'rust' },
  auto_install = true,
  highlight = {
    enable = true,
    disable = disable_func,
  },
  indent = { enable = true, disable = disable_func },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<TAB>',
      scope_incremental = '<CR>',
      node_decremental = '<S-TAB>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ao'] = '@block.outer',
        ['io'] = '@block.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['aC'] = '@conditional.outer',
        ['iC'] = '@conditional.inner',
        ['aO'] = '@class.outer',
        ['iO'] = '@class.inner',
        ['aA'] = '@assignment.inner',
        ['aX'] = '@assignment.lhs',
        ['aY'] = '@assignment.rhs',
        ['aG'] = '@comment.outer',
        ['iG'] = '@comment.inner',
        ['an'] = '@number.outer',
        ['in'] = '@number.inner',
        ['ar'] = '@return.outer',
        ['ir'] = '@return.inner',
        ['aR'] = '@regex.outer',
        ['iR'] = '@regex.inner',
        ['as'] = '@statement.outer',
        ['is'] = '@statement.inner',
        ['iS'] = '@scopename.inner',
        ['aS'] = '@scopename.outer',
        ['aP'] = '@parameter.outer',
        ['iP'] = '@parameter.inner',
        ['ia'] = '@attribute.inner',
        ['aa'] = '@attribute.outer',
        ['ac'] = '@call.outer',
        ['ic'] = '@call.inner',
      },
    },
  },
})

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Handle nvim-treesitter updates',
  group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
  callback = function(event)
    if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
      vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
      ---@diagnostic disable-next-line: param-type-mismatch
      local ok = pcall(vim.cmd, 'TSUpdate')
      if ok then
        vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
      else
        vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
      end
    end
  end,
})

vim.cmd 'doautocmd User TreesitterLoaded'
