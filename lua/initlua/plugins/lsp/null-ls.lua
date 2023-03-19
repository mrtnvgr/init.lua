local M = {}

M.ensure_installed = {
	"stylua", -- Lua formatting
	"black", -- Python formatting
	"isort", -- Python import formatting
	"autopep8", -- Python auto pep8 fixing
	"jsonlint", -- JSON Linting
	"actionlint", -- Github Actions YAML Linting
	"prettier", -- JSON, YAML, XML, Markdown, CSS, JS, HTML formatting
	"rustfmt", -- Rust formatter
}

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

	require("mason-null-ls").setup({
		ensure_installed = M.ensure_installed,
		automatic_installation = true,
		automatic_setup = true,
	})
	require("mason-null-ls").setup_handlers()
end

return M
