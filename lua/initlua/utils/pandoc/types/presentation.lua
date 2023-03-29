initlua.settings.pandoc.pdf = {
	themes = { "metropolis", "SimplePlus" },
}
table.sort(initlua.settings.pandoc.pdf)

function initlua.pandoc.compile_presentation(extension, theme, callback)
	initlua.pandoc.compile(extension, "beamer", {
		"--pdf-engine=lualatex",
		"--dpi=300",
		"-V",
		"theme=" .. theme,
	}, callback)
end

function initlua.pandoc.compile_presentation_as_pdf()
	vim.ui.select(initlua.settings.pandoc.pdf.themes, { prompt = "Select theme" }, function(theme)
		if not theme then
			return
		end

		initlua.pandoc.compile_presentation("pdf", theme, function(output)
			if vim.fn.executable("zathura") == 0 then
				return
			end

			local Job = require("plenary.job")
			Job:new({ command = "zathura", args = { output } }):start()
		end)
	end)
end

initlua.pandoc.types.Presentation = {
	pdf = initlua.pandoc.compile_presentation_as_pdf,
}
