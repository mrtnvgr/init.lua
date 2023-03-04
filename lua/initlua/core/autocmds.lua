local augroup = vim.api.nvim_create_augroup("Initlua", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
	desc = "Do not comment new lines",
	group = augroup,
	callback = function()
		local values = { "c", "r", "o" }
		for _, value in ipairs(values) do
			vim.opt_local.fo:remove(value)
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	desc = "Turn on wrapping on text files",
	group = augroup,
	pattern = { "*.md", "*.txt" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})
