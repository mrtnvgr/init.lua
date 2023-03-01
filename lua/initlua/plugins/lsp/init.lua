local function lsp_setup()
	local lsp = require("initlua.plugins.lsp.core")

	local cmp = require("cmp")

	local cmp_config = lsp.defaults.cmp_config({
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require("cmp-under-comparator").under,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		window = { completion = cmp.config.window.bordered() },
		preselect = "none",
		completion = { completeopt = "menu,menuone,noinsert,noselect" },
	})

	cmp.setup(cmp_config)

	require("initlua.plugins.lsp.servers")

	-- lsp.setup_servers({})

	require("neodev").setup() -- lsp.nvim_workspace()
	lsp.setup()

	-- null-ls setup
	local null_ls = require("null-ls")
	local null_opts = lsp.build_options("null-ls", {})

	null_ls.setup({
		on_attach = function(client, bufnr)
			null_opts.on_attach(client, bufnr)
			require("lsp-format").on_attach(client)
		end,
		sources = {},
	})

	require("mason-null-ls").setup({
		ensure_installed = {
			"stylua", -- Lua formatting
			"black", -- Python formatting
			"isort", -- Python import formatting
			"autopep8", -- Python auto pep8 fixing
			"jsonlint", -- JSON Linting
			"actionlint", -- Github Actions YAML Linting
			"prettier", -- JSON, YAML, XML, Markdown, CSS, JS, HTML formatting
		},
		automatic_installation = true,
		automatic_setup = true,
	})
	require("mason-null-ls").setup_handlers()

	-- Signs
	initlua.set_sign("DiagnosticSignInfo", "")
end

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VeryLazy",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
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
