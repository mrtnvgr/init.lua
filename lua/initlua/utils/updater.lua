initlua.updater = {}

function initlua.updater.update()
	local Job = require("plenary.job")

	Job:new({
		command = "git",
		args = { "pull", "--ff-only" },
		cwd = initlua.install_path,
		on_start = function()
			initlua.notify("Updating...")
		end,
		on_stderr = function(_, err)
			if err:match("^From") then
				initlua.notify("Repository pulled successfully! Please restart Neovim")
				initlua.settings._internals.update_available = true
			end
		end,
		on_exit = function()
			initlua.notify("Finished updating!")
		end,
	}):start()
end

function initlua.updater.update_plugins()
	initlua.notify("Updating plugins...")

	-- Update Tree-sitter
	-- ()() is necessary here
	require("nvim-treesitter.install").update()()

	-- Update LSP
	initlua.mason.update_all()
end

vim.api.nvim_create_user_command("InitluaUpdate", initlua.updater.update, { desc = "Update Everything" })

vim.api.nvim_create_autocmd("User", {
	desc = "Perform plugin updates",
	pattern = "VeryLazy",
	once = true,
	callback = function()
		if initlua.settings._internals.update_available then
			initlua.updater.update_plugins()
			initlua.settings._internals.update_available = false
		end
	end,
})
