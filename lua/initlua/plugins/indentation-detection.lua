return {
	{
		"Darazaki/indent-o-matic",
		event = "BufEnter",
		config = function()
			require("indent-o-matic").detect() -- Detect on BufEnter
			vim.cmd([[autocmd! indent_o_matic]]) -- Disable default autocmd
			vim.api.nvim_create_autocmd({ "BufReadPost", "InsertChange" }, {
				group = "indent_o_matic",
				callback = function()
					require("indent-o-matic").detect()
				end,
			})
		end,
	},
}
