return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				cmdline = { view = "cmdline" },

				messages = {
					-- TODO: ...
					view_search = false,
				},

				presets = {
					bottom_search = true,
					command_palette = false,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},

				routes = {
					-- Avoid written messages
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},

					-- Avoid search messages
					{
						filter = {
							event = "msg_show",
							kind = "search_count",
						},
						opts = { skip = true },
					},

					-- Avoid cargo clippy long message
					-- TODO: rename this message -> "Checking"
					{
						view = "mini",
						filter = { event = "lsp", kind = "progress", find = "cargo clippy" },
						opts = { skip = true },
					},
				},
			})

			-- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#lsp-messages
			vim.diagnostic.config({ update_in_insert = false })
		end,
	},
}
