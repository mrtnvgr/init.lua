require("initlua.options")

require("initlua.plugins-setup")

require("initlua.keymaps")
require("initlua.autocmds")

-- General utils
require("initlua.utils.init")
require("initlua.utils.reload")

-- Utils required for updating
require("initlua.utils.git")
require("initlua.utils.mason")
require("initlua.utils.lazy")
require("initlua.utils.updater")

-- Misc utils
require("initlua.utils.cs")
require("initlua.utils.format")
