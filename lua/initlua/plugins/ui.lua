return {
    {
        "folke/noice.nvim",
	    event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                cmdline = {
                    view = "cmdline",
                },

                messages = {
                    view_search = false,
                },

                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },

                presets = {
                    bottom_search = true,
                    command_palette = false,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = true,
                },
            })
        end,
    },

    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("notify").setup {
                fps = 60,
                timeout = 0,
                stages = "fade",
            }
        end,
    },

    { "stevearc/dressing.nvim", event = "VeryLazy" },
}
