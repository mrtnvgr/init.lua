return {
	{
		"Darazaki/indent-o-matic",
		event = "BufWinEnter",
		config = function()
			-- Detect on BufEnter
			require("indent-o-matic").detect()

			-- Disable default autocmd
			vim.api.nvim_clear_autocmds({ group = "indent_o_matic" })

			-- Create custom autocmd
			vim.api.nvim_create_autocmd({ "BufReadPost", "InsertChange" }, {
				group = "indent_o_matic",
				callback = function()
					require("indent-o-matic").detect()
				end,
			})
		end,
	},
}
