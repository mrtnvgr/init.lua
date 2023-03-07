require("rose-pine").setup({
	disable_float_background = true,
	-- TODO: workaround until https://github.com/rose-pine/neovim/pull/138 will be merged
	highlight_groups = {
		Cursor = { bg = "text", fg = "highlight_high" },
	},
})
