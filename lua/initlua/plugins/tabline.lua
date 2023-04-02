return {
	-- TODO: fix blinking
	"romgrk/barbar.nvim",
	event = "VeryLazy",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	opts = {
		animation = false,
		auto_hide = true,
		tabpages = false,

		icons = {
			button = "",
			pinned = { button = "車" },
			modified = { button = "●" },
			separator = { left = "", right = "" },
		},
	},
}
