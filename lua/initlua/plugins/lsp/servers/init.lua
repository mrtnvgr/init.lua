local M = {}

function M.get_servers()
	-- Require plenary modules
	local plenary_path = require("plenary.path")
	local plenary_scandir = require("plenary.scandir")

	-- Get servers path
	local path = plenary_path:new(initlua.install_path, "lua", "initlua", "plugins", "lsp", "servers")
	local path_sep = path._sep
	local servers = plenary_scandir.scan_dir(path.filename)

	for i, server in ipairs(servers) do
		-- Get filename from path
		server = vim.split(server, path_sep, { plain = true, trimempty = true })
		server = server[#server]

		-- Remove ".lua" prefix from filenames
		if server:match("init") then
			-- We don't want this file to be sourced again
			servers[i] = nil
		else
			servers[i] = server:gsub(".lua$", "")
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
			if settings ~= {} then
				lsp.configure(server, settings)
			end
		end
	end
end

return M
