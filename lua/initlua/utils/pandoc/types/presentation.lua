function initlua.pandoc.compile_presentation(extension, callback)
	initlua.pandoc.compile(extension, "beamer", {
		"--pdf-engine=lualatex",
		"--dpi=300",
		"-V",
		"theme=metropolis",
	}, callback)
end

function initlua.pandoc.compile_presentation_as_pdf()
	initlua.pandoc.compile_presentation("pdf", function(output)
		if vim.fn.executable("zathura") == 0 then
			return
		end

		local Job = require("plenary.job")
		Job:new({ command = "zathura", args = { output } }):start()
	end)
end

initlua.pandoc.types.Presentation = {
	pdf = initlua.pandoc.compile_presentation_as_pdf,
}
