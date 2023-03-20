require("kanagawa").setup({
	colors = {
		theme = {
			all = {
				ui = {
					float = {
						-- CR01
						bg = "NONE",
						bg_border = "NONE",
					},
					pmenu = {
						bg = "NONE",
						bg_sbar = "NONE",
					},

					-- CR02
					bg_gutter = "NONE",
				},
			},
		},
	},

	-- CR07
	overrides = function(colors)
		local theme = colors.theme
		return {
			-- CR06
			MsgArea = { link = "Normal" },

			-- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			-- PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },
		}
	end,
})
