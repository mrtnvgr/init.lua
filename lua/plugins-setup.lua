local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)
    use "wbthomason/packer.nvim"

    -- ==================================================

    -- Libraries

    -- Lua functions that many plugins use
    use "nvim-lua/plenary.nvim"

    -- Icons
    use "kyazdani42/nvim-web-devicons"

    -- ===================================================

    -- Improvements

    -- Faster startup
    use "lewis6991/impatient.nvim"

    -- Auto-pairs
    use "jiangmiao/auto-pairs"

    -- UI eye-candy
    use "stevearc/dressing.nvim"

    -- ===================================================

    -- Colorschemes

    -- Tokyonight
    use {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup { style = "night" }
        end
    }

    -- Gruvbox
    use "ellisonleao/gruvbox.nvim"

    -- Catppuccin
	use { "catppuccin/nvim", as = "catppuccin" }

    -- ===================================================

    -- Movement / Motions / Navigation

    -- Split window navigation
    use "christoomey/vim-tmux-navigator"

    -- better "jk", "jj" keymaps
    use {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end
    }

    -- ===================================================

    -- Commenting

    use "tpope/vim-commentary"

    -- ===================================================

    -- Status line

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    -- ===================================================

    -- LSP

    use {
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{"neovim/nvim-lspconfig"},             -- Required
			{"williamboman/mason.nvim"},           -- Optional
			{"williamboman/mason-lspconfig.nvim"}, -- Optional

			-- Autocompletion
			{"hrsh7th/nvim-cmp"},         -- Required
			{"hrsh7th/cmp-nvim-lsp"},     -- Required
			{"hrsh7th/cmp-buffer"},       -- Optional
			{"hrsh7th/cmp-path"},         -- Optional
			{"saadparwaiz1/cmp_luasnip"}, -- Optional
			{"hrsh7th/cmp-nvim-lua"},     -- Optional

			-- Snippets
			{"L3MON4D3/LuaSnip"},             -- Required
			{"rafamadriz/friendly-snippets"}, -- Optional
		}
	}

    -- ====================================================

    -- Treesitter

    use "nvim-treesitter/nvim-treesitter"

	use {
		"nvim-treesitter/playground",
		requires = {"nvim-treesitter/nvim-treesitter"},
	}

    use "windwp/nvim-ts-autotag"

    -- ====================================================

    -- Git integration
    use {
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	}

    -- ====================================================

    -- Wakatime

    use "wakatime/vim-wakatime"

    -- ====================================================

    -- Which-key

    use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {
				layout = {
					height = { min = 4, max = 30 },
					width = { min = 30, max = 40 }
				},
				window = {
					border = "single",
				}
			}
		end
	}

    -- ====================================================

    if packer_bootstrap then
        require("packer").sync()
    end
end)
