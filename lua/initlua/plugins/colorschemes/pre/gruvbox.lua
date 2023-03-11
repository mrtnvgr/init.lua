require("gruvbox").setup({
	inverse = false,
	contrast = "hard",
	overrides = {

		-- CR01
		Pmenu = { bg = "" },

		-- CR02
		SignColumn = { link = "Normal" },
		GruvboxGreenSign = { bg = "" },
		GruvboxOrangeSign = { bg = "" },
		GruvboxPurpleSign = { bg = "" },
		GruvboxYellowSign = { bg = "" },
		GruvboxRedSign = { bg = "" },
		GruvboxBlueSign = { bg = "" },
		GruvboxAquaSign = { bg = "" },

		MsgArea = { link = "Normal" },
		NoiceLspProgressTitle = { link = "Normal" },

		-- Fix cursor in noice.nvim
		NoiceCursor = { reverse = true },
	},
})
