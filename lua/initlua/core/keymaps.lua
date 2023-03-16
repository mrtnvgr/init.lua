vim.g.mapleader = " "

local map = vim.keymap.set

local defaults = { noremap = true, silent = true }

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
