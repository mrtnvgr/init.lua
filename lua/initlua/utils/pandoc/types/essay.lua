local function run(name, output)
	if vim.fn.executable(name) == 0 then
		return
	end

	local Job = require("plenary.job")
	Job:new({ command = name, args = { output } }):start()
end

local function libreoffice_callback(output)
	run("libreoffice", output)
end

function initlua.pandoc.compile_essay_to_office_document(extension)
	initlua.pandoc.compile(extension, extension, {}, libreoffice_callback)
end

function initlua.pandoc.compile_essay_as_odt()
	initlua.pandoc.compile_essay_to_office_document("odt")
end

function initlua.pandoc.compile_essay_as_docx()
	initlua.pandoc.compile_essay_to_office_document("docx")
end

initlua.pandoc.types.Essay = {
	docx = initlua.pandoc.compile_essay_as_docx,
	odt = initlua.pandoc.compile_essay_as_odt,
}
