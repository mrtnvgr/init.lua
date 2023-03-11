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
			sections = {
				lualine_x = {
					{ "filetype", color = { bg = "NONE" } },
				},
			},
		})

		-- Forcefully remove background from lualine
		vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "lualine_c_inactive", { bg = "NONE" })

		lualine.hide({
			place = { "tabline" },
			unhide = false,
		})
	end,
}
