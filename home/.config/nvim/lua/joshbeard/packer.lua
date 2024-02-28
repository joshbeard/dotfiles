-- Neovim Packer Configuration for Plugins
-- https://github.com/wbthomason/packer.nvim

-- Bootstrap packer.nvim if not installed
-- https://github.com/wbthomason/packer.nvim#bootstrapping
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

    --  use 'rstacruz/vim-closer'

    use {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
    --     config = function()
    --         vim.cmd('colorscheme rose-pine')
    --     end
    })

    use ({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.cmd('colorscheme catppuccin-mocha')
        end
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }

    use("nvim-treesitter/playground")
    use("github/copilot.vim")
    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("tpope/vim-surround")

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

    -- use("tpope/vim-fugitive")
    use {
        'tanvirtin/vgit.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    use {
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    }

    use 'ray-x/go.nvim'

    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"

    use 'ray-x/guihua.lua' -- recommended if need floating window support
    use 'terrortylor/nvim-comment'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'rhysd/git-messenger.vim'
    use 'norcalli/nvim-colorizer.lua'
    use 'beauwilliams/statusline.lua'
    use 'kosayoda/nvim-lightbulb'

    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }

    use {
        'gelguy/wilder.nvim',
        config = function()
            -- config goes here
        end,
    }

    -- TODO: fonts, configuration
    -- use 'wfxr/minimap.vim'
end)
