return {
	-- TODO: migrate to Telescope
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = true,
	},

	{
		"mrtnvgr/todo-comments.nvim",
		-- TODO: https://github.com/folke/todo-comments.nvim/pull/183
		branch = "fallback_searching",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlight = {
				before = "",
				keyword = "fg",
				after = "",
			},
			-- search = {
			-- 	command = "grep",
			-- 	args = {
			-- 		"--recursive",
			-- 		"--color=never",
			-- 		"--with-filename",
			-- 		"--line-number",
			-- 		"--binary-files=without-match",
			-- 		"--byte-offset",
			-- 		'--exclude-dir=".*"',
			-- 		"--extended-regexp",
			-- 	},
			-- 	pattern = ".*(KEYWORDS):",
			-- },
		},
	},
}
