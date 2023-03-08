local M = {}

M.lsp = require("lsp-zero").preset({
	name = "recommended",
	set_lsp_keymaps = { preserve_mappings = false },
	manage_nvim_cmp = false,
	suggest_lsp_servers = true,
})

return M.lsp
