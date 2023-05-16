require("catppuccin").setup({
	term_colors = true,
	custom_highlights = function(_)
		return {
			-- CR01
			Pmenu = { bg = "" },
			PmenuSbar = { bg = "" },
			NormalFloat = { bg = "" },
		}
	end,
})
