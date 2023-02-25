function initlua.update()
	-- Update Self
	local pull_status, _ = initlua.git.pull(false)
	if pull_status then
		initlua.notify("Repository pulled successfully")
		vim.cmd.InitluaReload()
	else
		initlua.err("Unable to pull repository")
	end

	-- Update Lazy
	initlua.lazy.update()

	-- Update Tree-sitter
	vim.cmd.TSUpdate()

	-- Update LSP
	initlua.mason.update_all()
end

vim.api.nvim_create_user_command("InitluaUpdate", initlua.update, { desc = "Update All Stuff" })
