require("nord").setup({
	-- Do not highlight errors
	styles = {
		errors = { undercurl = false },
	},
	errors = { mode = "none" },

	on_highlights = function(highlights, colors)
		-- CR01
		highlights.NormalFloat.bg = "NONE"
		highlights.NotifyBackground.bg = "NONE"
		highlights.WhichKeyFloat.bg = "NONE"
		highlights.Pmenu.bg = "NONE"
		highlights.PmenuSbar.bg = "NONE"
	end,
})
