return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local status, wk = pcall(require, "which-key")
			if not status then
				initlua.err("Failed to load which-key mappings")
				return
			end

			wk.setup({
				layout = {
					height = { min = 4, max = 30 },
					width = { min = 30, max = 40 },
				},
				window = {
					border = initlua.settings.ui.border,
				},
				ignore_missing = true,
			})

			wk.register({

				t = {
					name = "Tabs",
					o = { ":enew<CR>", "Open new buffer" },
					["<ENTER>"] = { ":enew<CR>", "Open new buffer" },

					x = { ":BufferClose<CR>", "Close current tab" },
					["<BS>"] = { ":BufferClose<CR>", "Close current tab" },

					n = { ":BufferNext<CR>", "Go to next tab" },
					["["] = { ":BufferNext<CR>", "Go to next tab" },

					p = { ":BufferPrevious<CR>", "Go to previous tab" },
					["]"] = { ":BufferPrevious<CR>", "Go to previous tab" },
				},

				s = {
					name = "Split current window",
					v = { "<C-w>v", "Split window vertically" },
					h = { "<C-w>s", "Split window horizontally" },
					e = { "<C-w>e", "Split window with equal width" },
					x = { ":close<CR>", "Close current window" },
				},
			}, {
				prefix = "<leader>",
			})
		end,
	},
}
