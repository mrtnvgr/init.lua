return {
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		event = "BufWinEnter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"python",
					"lua",
					"rust",
					"bash",
					"yaml",
					"json",
					"toml",
					"html",
					"vim",
					"help",
					"query",
					"regex",
					"markdown",
					"markdown_inline",
					"gitcommit",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				indent = { enable = true },

				autotag = { enable = true },

				context_commentstring = { enable = true, enable_autocmd = false },
			})
		end,
	},

	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"glimmer",
			"handlebars",
			"hbs",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
