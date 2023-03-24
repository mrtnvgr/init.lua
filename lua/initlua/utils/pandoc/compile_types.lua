function initlua.pandoc.compile_pdf_presentation()
	initlua.pandoc.compile("pdf", "beamer", {
		"--pdf-engine=lualatex",
		"--dpi=300",
		"-V",
		"theme=metropolis",
	}, function(output)
		if vim.fn.executable("zathura") == 0 then
			return
		end

		local Job = require("plenary.job")
		Job:new({ command = "zathura", args = { output } }):start()
	end)
end
