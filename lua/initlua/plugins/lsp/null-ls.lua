local M = {}

-- TODO: migrate
-- M.ensure_installed = {
-- 	"stylua", -- Lua formatting
-- 	"jsonlint", -- JSON Linting
-- 	"actionlint", -- Github Actions YAML Linting
-- 	"prettier", -- JSON, YAML, XML, Markdown, CSS, JS, HTML formatting
-- 	"rustfmt", -- Rust formatter
-- }

function M.setup()
	local lsp = require("initlua.plugins.lsp.core")

	local null_ls = require("null-ls")
	local null_opts = lsp.build_options("null-ls", {})

	null_ls.setup({
		border = initlua.settings.ui.border,
		on_attach = function(client, bufnr)
			null_opts.on_attach(client, bufnr)
			require("lsp-format").on_attach(client)
		end,
		sources = {},
	})

	local ensure_installed = {}

	for _, language in pairs(initlua.settings.languages) do
		if language.null_ls_enabled then
			ensure_installed = vim.tbl_extend("force", ensure_installed, language.null_ls_servers)
		end
	end

	require("mason-null-ls").setup({
		ensure_installed = ensure_installed,
		automatic_installation = true,
		automatic_setup = true,
	})
	require("mason-null-ls").setup_handlers()

	for _, language in pairs(initlua.settings.languages) do
		if not language.null_ls_enabled then
			for _, server in ipairs(language.null_ls_servers) do
				null_ls.disable({ name = server })
			end
		end
	end
end

return M
