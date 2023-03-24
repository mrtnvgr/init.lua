function initlua.pandoc.compile_pdf_presentation()
	initlua.pandoc.compile(
		"pdf",
		"beamer",
		{ "-V", "colortheme:metropolis", "-V", "mainfont:Cascadia Mono", "-V", "fontenc=T2A" },
		function(output)
			if vim.fn.executable("zathura") == 0 then
				return
			end

			local Job = require("plenary.job")
			Job:new({ command = "zathura", args = { output } }):start()
		end
	)
end
