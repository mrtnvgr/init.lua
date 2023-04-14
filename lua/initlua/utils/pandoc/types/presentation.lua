function initlua.pandoc.compile_presentation(extension, theme, callback)
	initlua.pandoc.compile(extension, "beamer", {
		"--pdf-engine=lualatex",
		"--dpi=" .. initlua.settings.pandoc.pdf.dpi,
		"-V",
		"theme=" .. theme,
		-- TODO: custom colors
	}, callback)
end

function initlua.pandoc.compile_presentation_as_pdf()
	local themes = vim.deepcopy(initlua.settings.pandoc.pdf.themes)
	table.sort(themes)
	table.insert(themes, "<-")

	vim.ui.select(themes, { prompt = "Select theme" }, function(theme)
		if not theme or theme == "<-" then
			return
		end

		initlua.pandoc.compile_presentation("pdf", theme, function(output)
			initlua.pandoc.callbacks.run("zathura", output)
		end)
	end)
end

function initlua.pandoc.compile_presentation_as_pptx()
	local themes = vim.deepcopy(initlua.settings.pandoc.pdf.themes)
	table.sort(themes)
	table.insert(themes, "<-")

	vim.ui.select(themes, { prompt = "Select theme" }, function(theme)
		if not theme or theme == "<-" then
			return
		end

		if vim.fn.executable("pdf2pptx") == 0 then
			initlua.err("pandoc: pdf2pptx is not installed on your system")
			return
		end

		initlua.pandoc.compile_presentation("pdf", theme, function(output)
			initlua.pandoc.callbacks.run("pdf2pptx", output, {
				args = { "--resolution", initlua.settings.pandoc.pdf.dpi, output },
				on_exit = function()
					os.remove(output)
					initlua.pandoc.callbacks.office(output:gsub(".pdf$", ".pptx"))
				end,
			})
		end)
	end)
end

initlua.pandoc.types.Presentation = {
	pdf = initlua.pandoc.compile_presentation_as_pdf,
	["pptx (using pdf2pptx)"] = initlua.pandoc.compile_presentation_as_pptx,
}
