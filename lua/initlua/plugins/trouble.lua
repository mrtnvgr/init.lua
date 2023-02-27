return {
	-- TODO: migrate to Telescope
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = true,
	},

	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local options = {
				highlight = {
					before = "",
					keyword = "fg",
					after = "",
				},
				search = {},
			}

			local rg_exists = vim.fn.executable("rg") == 1

			if not rg_exists then
				options.search.command = "grep"
				options.search.args = {
					"--recursive",
					"--color=never",
					"--with-filename",
					"--line-number",
					"--binary-files=without-match",
					"--byte-offset",
					'--exclude-dir=".*"',
					"--extended-regexp",
				}
				options.search.pattern = ".*(KEYWORDS):"
			end

			require("todo-comments").setup(options)
		end,
	},
}
