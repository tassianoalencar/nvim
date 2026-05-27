vim.loader.enable(true)

vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/tiagovla/tokyodark.nvim" },
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/echasnovski/mini.hipatterns" }
})

local bufnr = nil
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local hipatterns = require('mini.hipatterns')

vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.smartindent = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.completeopt = { 'fuzzy', 'menu', 'menuone', 'noinsert', 'popup' }
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.lsp.inlay_hint.enable(true)


vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufLeave" },
      focus = false,
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    if ev.data.name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      print('Build complete for ' .. ev.data.name)
    end
  end,
})

autocmd('BufReadPost', {
  pattern = "*",
  callback = function()
    if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then
      return
    end

    if vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 0 then
      return
    end

    local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype

    local has_parser, _ = pcall(vim.treesitter.get_parser, 0, lang)
    if has_parser then
      pcall(vim.treesitter.start)
    end
  end
})

vim.lsp.enable({
  "lua_ls",
  "intelephense",
  "vtsls",
  "tailwindcss",
  "pyright",
  "ruff"
})

autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    bufnr = ev.buf

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

          if #typed >= 2 and vim.fn.pumvisible() ~= 1 then
            vim.schedule(function()
              vim.lsp.completion.get()
            end)
            typed = ""
          end
        end,
      })

      autocmd("InsertLeave", {
        buffer = bufnr,
        callback = function() typed = "" end,
      })
    end

    keymap('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
    keymap('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover', silent = true })
    keymap('n', '<leader>cf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Code Format' })
    keymap('i', '<C-Space>', vim.lsp.completion.get)
    keymap('n', '<leader>cr', vim.lsp.buf.rename)
  end,
})

vim.diagnostic.config({
  virtual_text = false, -- Disable inline "virtual" text
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded', -- 'single', 'double', 'shadow', or 'rounded'
    source = 'always',  -- Show the source of the diagnostic (e.g., lua_ls, pyright)
    header = '',
    prefix = '',
  },
})

require('tokyodark').setup({
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    identifiers = { italic = false },
    functions = { italic = false },
    variables = { italic = false },
  },
})

hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require("tree-sitter-manager").setup({
  ensure_installed = { "lua", "php", "html", "javascript", "css" },
})

require("nvim-tree").setup()

telescope.setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    path_display = {
      filename_first = {
        reverse_directories = false,
      },
    }
  }
}

keymap('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
keymap('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
keymap('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })
keymap('n', '<leader>e', ':NvimTreeToggle<cr>')
keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP Code Actions" })

vim.cmd.colorscheme('tokyodark')
