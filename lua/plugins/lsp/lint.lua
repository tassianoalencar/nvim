local M = {
  'mfussenegger/nvim-lint'
}

M.lazy = true
M.event = 'User FileOpened'

M.dependencies = {
  'WhoIsSethDaniel/mason-tool-installer.nvim'
}

M.keys = {
  { '<leader>cl', function() require('lint').try_lint() end, desc = 'Lint' },
}

M.config = function()
  local lint = require 'lint'

  lint.linters_by_ft = {
    markdown = {'vale'},
    php = {'phpstan'},
    lua = {'luacheck'},
    python = {'pylint'},
    javascript = {'eslint'},
    typescript = {'eslint'},
    css = {'stylelint'},
    scss = {'stylelint'},
    html = {'htmlhint'},
    json = {'jsonlint'},
    yaml = {'yamllint'},
    sh = {'shellcheck'},
    dockerfile = {'hadolint'},
  }
end

return M
