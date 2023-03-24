function initlua.pandoc.menu()
	local opts = { "Presentation (PDF)" }

	vim.ui.select(opts, { prompt = "Select document type:" }, function(choice)
		if choice == "Presentation (PDF)" then
			initlua.pandoc.compile_presentation_as_pdf()
		end
	end)
end

vim.api.nvim_create_user_command("InitluaPandoc", initlua.pandoc.menu, { desc = "Open pandoc integration menu" })
vim.keymap.set("n", "<leader>apd", initlua.pandoc.menu)
