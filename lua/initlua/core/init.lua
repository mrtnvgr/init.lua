vim.g.mapleader = " "

local modules = {
	"autocmds",
	"options",
	"keymaps",
}

initlua.load_modules("initlua.core", modules)
