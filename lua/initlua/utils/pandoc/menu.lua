function initlua.pandoc.menu()
	local types = vim.tbl_keys(initlua.pandoc.types)
	table.sort(types)
	vim.ui.select(types, { prompt = "Select document type:" }, function(type)
		if not type then
			return
		end

		local extensions = vim.tbl_keys(initlua.pandoc.types[type])
		table.sort(extensions)
		table.insert(extensions, "<-")
		vim.ui.select(extensions, { prompt = "Select document extension:" }, function(extension)
			if not extension then
				return
			elseif extension == "<-" then
				vim.schedule(initlua.pandoc.menu)
				return
			end
			initlua.pandoc.types[type][extension]()
		end)
	end)
end

vim.api.nvim_create_user_command("InitluaPandoc", initlua.pandoc.menu, { desc = "Open pandoc integration menu" })
vim.keymap.set("n", "<leader>apd", initlua.pandoc.menu)
