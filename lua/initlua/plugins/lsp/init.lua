local function lsp_setup()
	-- Start LSP setup
	require("initlua.plugins.lsp.cmp").setup()
	require("initlua.plugins.lsp.servers").configure()

	-- Setup neovim workspace
	require("neodev").setup()

	-- Finish LSP setup
	require("initlua.plugins.lsp.core").setup()

	-- Setup Null-LS
	require("initlua.plugins.lsp.null-ls").setup()

	-- Diagnostic signs
	initlua.set_sign("DiagnosticSignInfo", "")

	-- Set border for :LspInfo window
	require("lspconfig.ui.windows").default_options.border = initlua.global_settings.ui.border
end

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VeryLazy",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						check_outdated_packages_on_open = false,
						border = initlua.global_settings.ui.border,
					},
				},
			},
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "lukas-reineke/cmp-under-comparator" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- Null-ls
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jay-babu/mason-null-ls.nvim" },
			{ "lukas-reineke/lsp-format.nvim" },

			-- Neovim cmp
			{ "folke/neodev.nvim" },
		},
		config = lsp_setup,
	},
}
