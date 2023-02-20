return {
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the four listed parsers should always be installed)
                ensure_installed = { "python", "lua", "vim", "query", "regex" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = false,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                indent = { enable = true },

                autotag = {
                    enable = true,
                },
            })
        end,
    },

    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
    },

    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "rescript",
            "xml",
            "php",
            "markdown",
            "glimmer","handlebars","hbs",
        },
    },
}
