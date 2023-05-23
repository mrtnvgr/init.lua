local select_some = function(some)
	if vim.fn.executable("oxidec") == 0 then
		initlua.err("oxidec is not installed!")
		return
	end

	local Job = require("plenary.job")
	Job:new({
		command = "oxidec",
		args = { some, "list", "--json" },
		on_exit = function(j, code)
			if code ~= 0 then
				initlua.err("oxidec: failed to get " .. some .. "s list")
				return
			end

			local result = table.concat(j:result(), "\n")

			local somes = vim.json.decode(result)
			if not somes then
				initlua.err("oxidec: failed to parse " .. some .. "s list")
				return
			end

			vim.ui.select(somes, { prompt = "Select " .. some }, function(choice)
				if not choice then
					return
				end

				Job:new({
					command = "oxidec",
					args = { some, "set", choice },
				}):sync()

				if some == "theme" then
					initlua.oxidec.colorscheme.set_from_cache()
				end
			end)
		end,
	}):start()
end

function initlua.oxidec.select_theme()
	select_some("theme")
end

function initlua.oxidec.select_wallpaper()
	select_some("wallpaper")
end

vim.api.nvim_create_user_command("OxidecSelectTheme", initlua.oxidec.select_theme, { desc = "Select a theme" })
vim.keymap.set("n", "<leader>ast", initlua.oxidec.select_theme)

vim.api.nvim_create_user_command(
	"OxidecSelectWallpaper",
	initlua.oxidec.select_wallpaper,
	{ desc = "Select a wallpaper" }
)
vim.keymap.set("n", "<leader>asw", initlua.oxidec.select_wallpaper)
