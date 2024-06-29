return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring"
  },
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  opts = {
    auto_install = true,
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "json", "typescript", "php", "html", "css" },
    highlight = { enable = true, use_languagetree = true },
    indent = { enable = true },
    rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,   -- automatically jump forward to matching textobj
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = false,
        swap_next = { ["<leader>a"] = "@parameter.inner" },
        swap_previous = { ["<leader>A"] = "@parameter.inner" },
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
  }
  -- config = function()
  --   local treesitter = require("nvim-treesitter.configs")
  --
  --   -- treesitter.setup {
  --   --   ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "json", "typescript", "php", "html", "css" },
  --   --   auto_install = true,
  --   --   indent = {
  --   --     enable = true
  --   --   },
  --   --   highlight = {
  --   --     enable = true,
  --   --     disable = function(lang, buf)
  --   --       local max_filesize = 100 * 1024 -- 100 KB
  --   --       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  --   --       if ok and stats and stats.size > max_filesize then
  --   --           return true
  --   --       end
  --   --     end,
  --   --   },
  --   --   autotag = {
  --   --     enable = true
  --   --   },
  --   --   incremental_selection = {
  --   --     enable = true,
  --   --     keymaps = {
  --   --       init_selection = "<C-space>",
  --   --       node_incremental = "<C-space>",
  --   --       scope_incremental = false,
  --   --       node_decremental = "<bs>"
  --   --     }
  --   --   },
  --   -- }
  -- end
}
