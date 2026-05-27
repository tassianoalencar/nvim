vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/tiagovla/tokyodark.nvim" },
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/echasnovski/mini.hipatterns" }
})

-- Builds Pack
vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    -- Check if the updated plugin requires a build step
    if ev.data.name == 'telescope-fzf-native.nvim' then
      vim.system({'make'}, { cwd = ev.data.path }):wait()
      print('Build complete for ' .. ev.data.name)
    end
  end,
})

vim.g.mapleader = " "
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

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = "*",
  callback = function()
    -- 1. Ignora buffers especiais, buffers sem nome ou previews do Telescope
    if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then 
      return 
    end

    -- 2. Só ativa se for um arquivo real e legível no disco (ignora buffers virtuais de preview)
    if vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 0 then
      return
    end

    -- 3. Pega a linguagem de forma segura
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype

    -- 4. Executa o Tree-sitter de forma totalmente protegida
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
  "tailwindcss"
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

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

      vim.api.nvim_create_autocmd("InsertLeave", {
        buffer = bufnr,
        callback = function() typed = "" end,
      })
    end

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover', silent = true })
    vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Code Format' })
    vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename)
  end,
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

vim.cmd.colorscheme('tokyodark')

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require("tree-sitter-manager").setup({
  ensure_installed = { "lua", "php", "html", "javascript", "css" },
})

-- NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')


-- Telescope
local telescope = require('telescope')
local builtin = require('telescope.builtin')

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

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
