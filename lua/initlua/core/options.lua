local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smarttab = true
opt.smartindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor & mouse
opt.guicursor = ""
opt.mouse = "a"

-- appearance
opt.termguicolors = true
opt.updatetime = 100

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- sign column
opt.signcolumn = "yes"

-- spell
opt.spelllang:append("en,ru")

-- backups & undo
opt.backup = false
opt.undofile = true

-- short mess
opt.shortmess:append("I") -- do not show intro message
opt.shortmess:append("s") -- do not show "search hit BOTTOM ..."

-- insert complete menu
opt.completeopt = "menu,menuone,noselect"
