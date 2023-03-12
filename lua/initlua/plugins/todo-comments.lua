return {
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
			}

			if vim.fn.executable("rg") == 0 then
				options.search = {
					command = "grep",
					args = {
						"--recursive",
						"--color=never",
						"--with-filename",
						"--line-number",
						"--binary-files=without-match",
						"--byte-offset",
						'--exclude-dir=".*"',
						"--extended-regexp",
					},
					pattern = ".*(KEYWORDS):",
				}
			end

			require("todo-comments").setup(options)
		end,
	},
}
