local M = {}

local lsp = require("initlua.plugins.lsp.core")

-- TODO: this does not need to be hardcoded
-- use: "return {}" for no configuration
M.ensure_installed = {
    "pyright", -- Python
    "lua_ls", -- Lua
    "vimls", -- Vim stuff
    "jsonls", -- JSON
    "yamlls", -- YAML
    "taplo", -- TOML
    "ltex", -- Language
}

lsp.ensure_installed(M.ensure_installed)

for _, server in ipairs(M.ensure_installed) do
    local path = "initlua.plugins.lsp.servers." .. server
    local status, settings = pcall(require, path)

end

lsp.configure("pyright", {
    settings = {
        python = {
            -- Turn off type checking
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
})

lsp.configure("lua_ls", {
    settings = {
        lua = {
            format = {
                -- using null-ls formatting instead
                enable = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

lsp.configure("yamlls", {
    settings = {
        redhat = { telemetry = { enabled = false } },
    },
})

lsp.configure("ltex", {
    settings = {
        ltex = {
            -- https://valentjn.github.io/ltex/advanced-usage.html#magic-comments
            language = "en-US",
            additionalRules = {
                motherTongue = "ru-RU",
                enablePickyRules = true,
            },
            completionEnabled = true,
            disabledRules = {
                ["en-US"] = {
                    -- Write notes peacefully
                    "UPPERCASE_SENTENCE_START",
                    -- "I can use whatever symbol I want!"
                    "COPYRIGHT",
                    -- I think nobody uses these quotes digitally...
                    "EN_QUOTES",
                    -- I love passive voice!
                    "PASSIVE_VOICE",
                },
            },
        },
    },
})
