local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) and vim.fn.executable("git") ~= 0 then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "initlua.plugins",
	defaults = { lazy = true },
	ui = { border = "single" },
	install = {
		missing = true, -- turn on explicitly
		colorscheme = {
			"tokyonight-night",
			"habamax",
		},
		checker = {
			enabled = false, -- turn off explicitly
		},
	},
})
