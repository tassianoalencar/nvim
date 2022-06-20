vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- UI
    use({ "themercorp/themer.lua" })
    use({ "RRethy/vim-illuminate" })
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
    use({ "akinsho/nvim-bufferline.lua", requires = "kyazdani42/nvim-web-devicons" })
    use({ "kazhala/close-buffers.nvim" })

    -- Treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "nvim-treesitter/nvim-treesitter-refactor" })

    -- Autopairs
    use({ "windwp/nvim-autopairs" })
    use({ "windwp/nvim-ts-autotag" })

    -- Nvim Tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

    -- Telescope
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" } })

    -- Lsp and completion
    use({ "williamboman/nvim-lsp-installer" })
    use({ "neovim/nvim-lspconfig" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "ray-x/lsp_signature.nvim", commit = "4852d99f9511d090745d3cc1f09a75772b9e07e9" })

    -- Cmp
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-cmdline" })
    use({ "hrsh7th/nvim-cmp" })

    -- Snippets
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
end)
