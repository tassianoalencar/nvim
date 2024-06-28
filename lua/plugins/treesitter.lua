return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "windwp/nvim-ts-autotag"
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "json", "typescript", "php", "html", "css" },
      auto_install = true,
      indent = {
        enable = true
      },
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
        end,
      },
      autotag = {
        enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>"
        }
      },
    }
  end
}
