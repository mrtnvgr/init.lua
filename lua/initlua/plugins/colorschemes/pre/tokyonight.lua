require("tokyonight").setup({
	style = "night",

	-- CR01
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},

	on_highlights = function(hl, _)
		-- CR01
		hl.Pmenu = { bg = "NONE" }
		hl.PmenuSbar = { bg = "NONE" }
	end,
})
