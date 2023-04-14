function initlua.pandoc.compile_essay_to_office_document(extension)
	initlua.pandoc.compile(extension, extension, {}, initlua.pandoc.callbacks.office)
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
