initlua.updater = {}

function initlua.updater.update()
	local Job = require("plenary.job")

	Job:new({
		command = "git",
		args = { "pull", "--ff-only" },
		cwd = initlua.install_path,
		on_stderr = function(_, err)
			if err:match("^From") then
				initlua.notify("Repository pulled successfully!")
			elseif err:match("^error: please commit or stash them.$") then
				initlua.notify(
					"Failed to pull repository!\nPlease stash or commit your local changes.",
					vim.log.levels.WARN
				)
			elseif err:match("^fatal: unable to access") then
				initlua.err("Failed to pull repository!\nNo internet connection.")
			else
				return
			end

			initlua.settings._internals.update_available = true
		end,
		on_exit = function()
			initlua.notify("Update completed, please restart Neovim")
		end,
	}):start()
end

vim.api.nvim_create_user_command("InitluaUpdate", initlua.updater.update, { desc = "Update Everything" })

vim.api.nvim_create_autocmd("User", {
	desc = "Perform plugin updates",
	pattern = "VeryLazy",
	once = true,
	callback = function()
		if initlua.settings._internals.update_available then
			require("lazy").sync()
			initlua.settings._internals.update_available = false
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	desc = "Perform treesitter and Mason updates",
	pattern = "LazySync",
	once = true,
	callback = function()
		require("nvim-treesitter.install").update()()
		initlua.mason.update_all()
	end,
})

vim.keymap.set("n", "<leader>au", initlua.updater.update)
