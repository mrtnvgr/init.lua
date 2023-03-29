local M = {}

function M.get_servers()
	local servers = {}
	for _, language in pairs(initlua.settings.languages) do
		if language.lsp_enabled then
			servers = vim.list_extend(servers, language.lsp_servers)
		end
	end
	return servers
end

function M.configure()
	local servers = M.get_servers()
	local lsp = require("initlua.plugins.lsp.core")

	lsp.ensure_installed(servers)

	for _, server in ipairs(servers) do
		local ok, settings = pcall(require, "initlua.plugins.lsp.servers." .. server)
		if ok then
			-- Configure server only if any configuration is present
			if not vim.tbl_isempty(settings) then
				lsp.configure(server, settings)
			end
		end
	end
end

return M
