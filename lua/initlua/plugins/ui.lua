return {
	{
		"rcarriga/nvim-notify",
		event = { "VimEnter" },
		opts = {
			fps = 144,
			timeout = 2500,
			stages = "fade",
		},
	},

	{ "stevearc/dressing.nvim", event = "VeryLazy" },
}
