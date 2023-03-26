local function libreoffice(output)
	if vim.fn.executable("libreoffice") == 0 then
		return
	end

	local Job = require("plenary.job")
	Job:new({ command = "libreoffice", args = { output } }):start()
end

function initlua.pandoc.compile_essay(extension, callback)
	initlua.pandoc.compile(extension, extension, {}, callback)
end

function initlua.pandoc.compile_essay_as_odt()
	initlua.pandoc.compile_essay("odt", libreoffice)
end

function initlua.pandoc.compile_essay_as_docx()
	initlua.pandoc.compile_essay("docx", libreoffice)
end
