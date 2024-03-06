-- --------------------------------------------------------------
-- Packer Plugin Configuration
-- --------------------------------------------------------------
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- https://github.com/wbthomason/packer.nvim#bootstrapping
    if packer_bootstrap then
        require('packer').sync()
    end

    -- telescope (file pick, grep, etc)
    use {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- color scheme
    use ({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.cmd('colorscheme catppuccin-mocha')
        end
    })

    -- parser and syntax highlighter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }

    -- GitHub Copilot
    use("github/copilot.vim")

    -- file switcher
    use("theprimeagen/harpoon")

    -- undo tree
    use("mbbill/undotree")

    -- surround
    use("tpope/vim-surround")

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- git tools
    use("tpope/vim-fugitive")
    use {
        'tanvirtin/vgit.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- file explorer
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    -- highlight TODO, FIXME, etc
    use {
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    }

    -- go support
    use 'ray-x/go.nvim'

    -- gui library
    use 'ray-x/guihua.lua'

    -- toggle comments
    use 'terrortylor/nvim-comment'

    -- indent guides
    use 'lukas-reineke/indent-blankline.nvim'

    -- statusline
    use 'beauwilliams/statusline.lua'

    -- terminal
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }

    -- command palette
    use {
        'gelguy/wilder.nvim',
        config = function()
            -- config goes here
        end,
    }
end)
