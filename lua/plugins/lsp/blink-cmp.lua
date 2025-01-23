local M = { 'saghen/blink.cmp' }

M.version = "v0.10.0"

---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {
  keymap = {
    preset = 'enter',

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<C-j>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
  },
  signature = {
    window = { border = 'single' }
  },
  completion = {
    menu = { border = 'single' },
    documentation = {
      auto_show = true,
      window = { border = 'single' }
    },
    accept = {
      auto_brackets = {
        enabled = true
      }
    },
    list = {
      selection = {
        preselect = function (contexto)
          return contexto.mode ~= 'cmdline'
        end
      }
    },
  }
}

return M
