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
		opts = {
			highlight = {
				before = "",
				keyword = "fg",
				after = "",
			},
		},
	},
}
