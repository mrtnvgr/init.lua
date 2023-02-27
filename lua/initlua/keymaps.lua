vim.g.mapleader = " "

local map = vim.keymap.set

local defaults = { noremap = true, silent = true }

-- Which-key keymaps

local status, wk = pcall(require, "which-key")
if not status then
	return
end

wk.register({

	t = {
		name = "Tabs",
		o = { ":tabnew<CR>", "Open new tab" },
		x = { ":BufferClose<CR>", "Close current tab" },
		n = { ":BufferNext<CR>", "Go to next tab" },
		p = { ":BufferPrevious<CR>", "Go to previous tab" },
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
