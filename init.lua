-- ==========================================================================
-- Packages
-- ==========================================================================
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/tiagovla/tokyodark.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/echasnovski/mini.hipatterns" },
  { src = "https://github.com/arborist-ts/arborist.nvim" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/rose-pine/neovim" }
})

-- Variables ====================================================================
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set
local bufnr = nil
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local hipatterns = require('mini.hipatterns')
local servers = { "lua_ls", "intelephense", "vtsls", "tailwindcss", "pyright", "ruff", "html" }

-- General ====================================================================
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- vim.opt.foldmethod = "expr"
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.completeopt = { 'fuzzy', 'menu', 'menuone', 'noinsert', 'popup' }
vim.opt.updatetime = 300
vim.opt.cmdheight = 0
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.pumheight = 10
vim.o.clipboard = 'unnamedplus'
vim.o.winborder = "double"
vim.lsp.inlay_hint.enable(true)
vim.lsp.enable(servers)

-- Autocmds ====================================================================
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

autocmd("CursorHold", {
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

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob",
      "!**/.git/*",
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--smart-case" },
      },
    },
    path_display = {
      filename_first = {
        reverse_directories = false,
      },
    }
  }
}

require("nvim-tree").setup()
require("arborist").setup()

-- Keymaps
keymap('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
keymap('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
keymap('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })
keymap('n', '<leader>e', ':NvimTreeToggle<cr>')
keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
keymap('n', '<leader>sr', ':source %<cr>', { desc = 'Reload buffer code' })
keymap('n', '<leader>si', ':Inspect<cr>', { desc = 'Reload buffer code' })
keymap('n', '<leader>bd', ':bdelete<cr>', { desc = 'Reload buffer code' })
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('v', '<leader>n', [[:s/^/\=line('.') - line("'<") + 1 . '. '<CR>]], { silent = true })

-- Themes
require("rose-pine").setup({
  styles = {
    bold = false,
    italic = false,
    transparency = true,
  },
})

vim.cmd("colorscheme rose-pine")

-- local themes = {}
--
-- local palettes = {
--   maguh = {
--     background = "#1B1B1B",
--
--     gray = {
--       darkest  = "#0D0D0D",
--       darker   = "#121212",
--       dark     = "#1B1B1B",
--       medium   = "#252525",
--       light    = "#303030",
--       lighter  = "#404040",
--       soft     = "#525252",
--       muted    = "#737373",
--       text_dim = "#A3A3A3",
--       text     = "#EAEAEA",
--     },
--
--     accent = {
--       blue = {
--         base  = "#3B82F6",
--         hover = "#60A5FA",
--       },
--
--       green = {
--         base  = "#22C55E",
--         hover = "#4ADE80",
--       },
--
--       orange = {
--         base  = "#F97316",
--         hover = "#FB923C",
--       }
--     }
--   }
-- }
--
-- themes.highlights = {
--
--   -- Padrão do Editor (UI)
--   Normal      = { fg = palettes.maguh.gray.text, bg = palettes.maguh.background },
--   Comment     = { fg = palettes.maguh.gray.light },
--   CursorLine  = { bg = palettes.maguh.gray.medium },
--   Visual      = { bg = palettes.maguh.gray.medium },
--
--   FloatBorder = { bg = palettes.maguh.background },
--   NormalFloat = { bg = palettes.maguh.gray.dark },
--
--   Pmenu       = { bg = palettes.maguh.gray.medium },
--   PmenuSel    = { bg = palettes.maguh.gray.light },
--
--   -- Sintaxe Básica (Cores Principais)
--   Keyword     = { fg = palettes.maguh.accent.green.base },
--   Function    = { fg = palettes.maguh.accent.blue.base },
--   Type        = { fg = palettes.maguh.accent.orange.base },
--   -- String            = { fg = theme.palette.string },
--   -- Type              = { fg = theme.palette.class },
--   -- PreProc           = { fg = theme.palette.keyword, bold = true },
--   -- Statement         = { fg = theme.palette.keyword, bold = true },
--
--   -- Suporte Completo ao Neovim Treesitter (@tags)
--   ["@type.builtin"] = { fg = palettes.maguh.accent.orange.base },
--   -- ["@function.method"] = { fg = theme.palette.func },
--   -- ["@constructor"] = { fg = theme.palette.func },
--   -- ["@variable.builtin"] = { fg = theme.palette.class },
-- }
--
-- vim.cmd("highlight clear")
--
-- if vim.fn.exists("syntax_on") == 1 then
--   vim.cmd("syntax reset")
-- end
--
-- vim.g.colors_name = "maguh_theme"
--
-- for group, opts in pairs(themes.highlights) do
--   vim.api.nvim_set_hl(0, group, opts)
-- end
--
-- hipatterns.setup({
--   highlighters = {
--     hex_color = hipatterns.gen_highlighter.hex_color(),
--   },
-- })
