local M = {}

function M.get_servers()
	local enabled_servers = {}
	local disabled_servers = {}
	for _, language in pairs(initlua.settings.languages) do
		if language.lsp_enabled then
			enabled_servers = vim.list_extend(enabled_servers, language.lsp_servers)
		else
			disabled_servers = vim.list_extend(disabled_servers, language.lsp_servers)
		end
	end
	return enabled_servers, disabled_servers
end

function M.configure()
	local enabled_servers, disabled_servers = M.get_servers()
	local lsp = require("initlua.plugins.lsp.core")

	lsp.ensure_installed(vim.tbl_map(function(server)
		return server:gsub("-", "_")
	end, enabled_servers))

	for _, server in ipairs(enabled_servers) do
		local ok, settings = pcall(require, "initlua.plugins.lsp.servers." .. server)
		if ok then
			-- Configure server only if any configuration is present
			if not vim.tbl_isempty(settings) then
				lsp.configure(server:gsub("-", "_"), settings)
			end
		end
	end

	lsp.skip_server_setup(disabled_servers)
end

return M
