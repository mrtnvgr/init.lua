return {
	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VeryLazy",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "f3fora/cmp-spell" },
			{ "lukas-reineke/cmp-under-comparator" },
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional

			-- Null-ls
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jay-babu/mason-null-ls.nvim" },
			{ "lukas-reineke/lsp-format.nvim" },
		},
		config = function()
			local lsp = require("lsp-zero").preset({
				name = "recommended",
				set_lsp_keymaps = true,
				manage_nvim_cmp = false,
				suggest_lsp_servers = true,
			})

			lsp.on_attach(function(_, bufnr)
				local opts = { buffer = bufnr }
				local bind = vim.keymap.set

				bind("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
			end)

			local cmp_sources = lsp.defaults.cmp_sources()
			table.insert(cmp_sources, { name = "spell" })

			local cmp = require("cmp")

			local cmp_config = lsp.defaults.cmp_config({
				sources = cmp_sources,
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

			lsp.ensure_installed({
				"pyright", -- Python
				"lua_ls", -- Lua
				"vim_ls", -- Vim stuff
				"jsonls", -- JSON
				"yamlls", -- YAML
			})

			lsp.configure("pyright", {
				settings = {
					python = {
						-- Turn off type checking
						analysis = {
							diagnosticSeverityOverrides = {
								reportGeneralTypeIssues = "none",
								reportOptionalMemberAccess = "none",
							},
						},
					},
				},
			})

			lsp.configure("lua_ls", {
				settings = {
					lua = {
						diagnostics = {
							globals = { "vim" },
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- lsp.setup_servers({})

			lsp.nvim_workspace()

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
					"prettier", -- JSON, YAML, XML, Markdown, CSS, JS, HTML formatting
				},
				automatic_installation = true,
				automatic_setup = true,
			})
			require("mason-null-ls").setup_handlers()
		end,
	},
}
