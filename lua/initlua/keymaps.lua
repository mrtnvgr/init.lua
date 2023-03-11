vim.g.mapleader = " "

local map = vim.keymap.set

local defaults = { noremap = true, silent = true }

-- Which-key keymaps

local status, wk = pcall(require, "which-key")
if not status then
	initlua.err("Failed to load which-key mappings")
	return
end

wk.register({

	t = {
		name = "Tabs",
		o = { ":enew<CR>", "Open new buffer" },
		["<ENTER>"] = { ":enew<CR>", "Open new buffer" },

		x = { ":BufferClose<CR>", "Close current tab" },
		["<BS>"] = { ":BufferClose<CR>", "Close current tab" },

		n = { ":BufferNext<CR>", "Go to next tab" },
		["["] = { ":BufferNext<CR>", "Go to next tab" },

		p = { ":BufferPrevious<CR>", "Go to previous tab" },
		["]"] = { ":BufferPrevious<CR>", "Go to previous tab" },
	},

	s = {
		name = "Split current window",
		v = { "<C-w>v", "Split window vertically" },
		h = { "<C-w>s", "Split window horizontally" },
		e = { "<C-w>e", "Split window with equal width" },
		x = { ":close<CR>", "Close current window" },
	},
}, {
	prefix = "<leader>",
})

-- General keymaps

-- Clear search highlights
map("n", "<leader>nh", ":nohl<CR>", defaults)

-- Do not yank symbols on "x"
map("n", "x", '"_x')

-- Increment/Decrement numbers
map("n", "<leader>+", "<C-a>")
map("n", "<leader>-", "<C-x>")

-- Disable arrow keys
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Don't copy when pasting over selection
map("v", "p", '"_dP')
map("v", "P", '"_dp')

-- Initlua's keymaps
map("n", "<leader>au", initlua.update)
map("n", "<leader>asc", initlua.select_colorscheme)
