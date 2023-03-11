return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		local lualine = require("lualine")

		local custom_auto = require("lualine.themes.auto")
		custom_auto.normal.c.bg = "NONE"

		lualine.setup({
			options = {
				theme = custom_auto,
				section_separators = "",
				component_separators = "",
			},
			refresh = {
				statusline = vim.opt.updatetime,
			},
		})

		lualine.hide({
			place = { "tabline" },
			unhide = false,
		})
	end,
}
