vim.g.mapleader = " "

require("initlua.core.options")

require("initlua.plugins-setup")

require("initlua.core.keymaps")
require("initlua.core.autocmds")

-- General utils
require("initlua.core.utils.init")
require("initlua.core.utils.reload")

-- Utils required for updating
require("initlua.core.utils.git")
require("initlua.core.utils.mason")
require("initlua.core.utils.lazy")
require("initlua.core.utils.updater")

-- Misc utils
require("initlua.core.utils.cs")
require("initlua.core.utils.format")
