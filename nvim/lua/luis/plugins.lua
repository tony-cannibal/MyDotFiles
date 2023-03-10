
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
            return require("packer.util").float({ border = "rounded" })
		end,
	},
})


return packer.startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'nvim-lua/plenary.nvim'}
    use {'numToStr/Comment.nvim'}
    use {"akinsho/toggleterm.nvim"}
    use {"lukas-reineke/indent-blankline.nvim"}
    use {'kyazdani42/nvim-web-devicons'}
    use {'nvim-telescope/telescope.nvim', tag = '0.1.0'}
    use {'lewis6991/impatient.nvim'}

    use {'sainnhe/everforest'}
    use { 'ishan9299/nvim-solarized-lua' }

    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},         -- Required
        {'hrsh7th/cmp-nvim-lsp'},     -- Required
        {'hrsh7th/cmp-buffer'},       -- Optional
        {'hrsh7th/cmp-path'},         -- Optional
        {'saadparwaiz1/cmp_luasnip'}, -- Optional
        {'hrsh7th/cmp-nvim-lua'},     -- Optional

        -- Snippets
        {'L3MON4D3/LuaSnip'},             -- Required
        {'rafamadriz/friendly-snippets'}, -- Optional
      }
    }
    use {"jose-elias-alvarez/null-ls.nvim"}
    use { "jay-babu/mason-null-ls.nvim" }
    use { "RRethy/vim-illuminate" }

    use { 'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use {'JoosepAlviste/nvim-ts-context-commentstring'}
    use {'norcalli/nvim-colorizer.lua'}
    use {'petertriho/nvim-scrollbar'}
    use {'tpope/vim-fugitive'}
    use {"windwp/nvim-autopairs"}

    use {'nvim-lualine/lualine.nvim'}
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use {'goolord/alpha-nvim'}
    use {"folke/which-key.nvim"}

    use {'nvim-tree/nvim-tree.lua'}

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)


