vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	once = true,
	callback = function()
		local async = require("plenary.async")

		vim.ui.async = {}
		vim.ui.async.select = async.wrap(function(items, opts, callback)
			vim.ui.select(items, opts, callback)
		end, 3)
	end,
})
