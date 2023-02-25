local cmd = vim.cmd

-- Do not comment new lines
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

cmd([[
	command! W :w
	command! Q :q
]])

local augroup = vim.api.nvim_create_augroup("Initlua", {})
vim.api.nvim_clear_autocmds({ group = augroup })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	desc = "Turn on wrapping on text files",
	group = augroup,
	pattern = { "*.md", "*.txt" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	desc = "Run cs on colorscheme change",
	group = augroup,
	callback = function()
		initlua.cs.set(vim.fn.expand("<amatch>"))
	end,
})
