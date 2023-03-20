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
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },
		}
	end,
})
