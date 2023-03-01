local M = {}

M.lsp = require("lsp-zero").preset({
	name = "recommended",
	set_lsp_keymaps = true,
	manage_nvim_cmp = false,
	suggest_lsp_servers = true,
})

M.lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr }
	local bind = vim.keymap.set

	bind("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
end)

return M.lsp
