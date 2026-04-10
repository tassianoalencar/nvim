-- plugins instalations
--------------------------------------------------------------------------------
vim.pack.add({
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/akinsho/git-conflict.nvim' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter',            version = "main" },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  { src = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' },
  { src = 'https://github.com/chrisgrieser/nvim-various-textobjs' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/tiagovla/tokyodark.nvim' }
})

-- options
--------------------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.completeopt = { 'fuzzy', 'menu', 'menuone', 'noinsert', 'popup' }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.pumblend = 10
vim.opt.pumborder = 'rounded'
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append('c')
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.timeoutlen = 400
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldminlines = 1
vim.o.swapfile = false
vim.o.cmdheight = 0
vim.o.wrap = false
vim.o.scrolloff = 1

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- general keymap
--------------------------------------------------------------------------------
vim.keymap.set('n', '<C-S-Up>', ':resize +5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Down>', ':resize -5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Left>', ':vertical resize -5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Right>', ':vertical resize +5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-h>', ':bprev<cr>', { noremap = true, silent = true, desc = 'Previous Buffer' })
vim.keymap.set('n', '<S-l>', ':bnext<cr>', { noremap = true, silent = true, desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bd', ':bd<cr>', { noremap = true, silent = true, desc = 'Delete Buffer' })
vim.keymap.set('n', '<Esc>', ':noh<cr>', { noremap = true, silent = true, desc = 'Clear Highlight' })

vim.lsp.enable({ "lua_ls", "intelephense", "html", "marksman", "tailwindcss", "vtsls", "jdtls", "rust_analyzer" })

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
  end,
})

vim.diagnostic.config({
  underline = false,
  virtual_text = true,
  severity_sort = true,
})

-- autocmd
--
--------------------------------------------------------------------------------
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require('git-conflict').setup()

vim.keymap.set('n', '<leader>gcc', '<Plug>(git-conflict-ours)', { silent = true, desc = 'Git Conflict Current' })
vim.keymap.set('n', '<leader>gci', '<Plug>(git-conflict-theirs)', { silent = true, desc = 'Git Conflict Incoming' })
vim.keymap.set('n', '<leader>gcb', '<Plug>(git-conflict-both)', { silent = true, desc = 'Git Conflict Both' })
vim.keymap.set('n', '<leader>gcN', '<Plug>(git-conflict-none)', { silent = true, desc = 'Git Conflict None' })
vim.keymap.set('n', '<leader>gcn', '<Plug>(git-conflict-prev-conflict)', { silent = true, desc = 'Git Conflict Next' })
vim.keymap.set('n', '<leader>gcp', '<Plug>(git-conflict-next-conflict)', { silent = true, desc = 'Git Conflict Prev' })

require("nvim-autopairs").setup({})

require("various-textobjs").setup({
  keymaps = {
    useDefaults = true
  }
})

require("nvim-treesitter.configs").setup({
  additional_vim_regex_highlighting = false,
  ensure_installed = { 'lua', 'tsx', 'typescript', 'vimdoc', 'vim', 'regex', 'bash', 'markdown_inline', 'markdown', 'angular', 'html', 'css', 'scss', 'javascript', 'json', 'yaml', 'toml', 'python' },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
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

-- Coloscheme
--------------------------------------------------------------------------------
require('tokyodark').setup({
  transparent_background = true,                                          -- set background to transparent
  styles = {
    comments = {},                                          -- style for comments
    keywords = {},                                          -- style for keywords
    identifiers = {},                                       -- style for identifiers
    functions = {},                                                        -- style for functions
    variables = {},                                                        -- style for variables
  },
})
vim.cmd.colorscheme('tokyodark')


-- which-key
--------------------------------------------------------------------------------
local wk = require("which-key")

wk.setup({
  -- preset = "helix",
  delay = 0
})

wk.add({
  { "<leader>f",  group = "Find" },
  { "<leader>g",  group = "Git" },
  { "<leader>gc", group = "Conflict" },
  { "<leader>b",  group = "Buffers" },
  { "<leader>c",  group = "Code" },
  { "<leader>u",  group = "Ui" },
  { "<leader>uo", "<cmd>update<cr><cmd>source<cr>", desc = "Update and Source" },
})

-- mini
--------------------------------------------------------------------------------
require('mini.tabline').setup()

-- snacks
--------------------------------------------------------------------------------
require('snacks').setup({
  indent = { enabled = true },
  explorer = { enabled = true },
  picker = { enabled = true },
  input = { enabled = true },
  dim = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
})

vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fw', function() Snacks.picker.grep() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = 'Find Files' })
