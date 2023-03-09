function initlua.update()
	-- Update Self
	local pull_status, _ = initlua.git.pull(false)
	if pull_status then
		initlua.notify("Repository pulled successfully")
		initlua.reload()
	else
		initlua.err("Unable to pull repository")
	end

	-- Update Lazy
	initlua.lazy.update()

	-- Update Tree-sitter
	-- ()() is necessary here
	require("nvim-treesitter.install").update()()

	-- Update LSP
	initlua.mason.update_all()

	-- TODO: cache support
end

vim.api.nvim_create_user_command("InitluaUpdate", initlua.update, { desc = "Update All Stuff" })
