return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
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
