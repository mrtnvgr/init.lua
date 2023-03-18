return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		local lualine = require("lualine")

		local theme = require("lualine.themes.auto")
		local modes = { "normal", "insert", "visual", "replace", "command", "inactive" }
		for _, mode in ipairs(modes) do
			theme[mode].c.bg = "NONE"
		end

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
