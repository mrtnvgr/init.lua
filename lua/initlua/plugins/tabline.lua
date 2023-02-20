return {
    "romgrk/barbar.nvim",
    lazy = false,
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        require("bufferline").setup({
            animation = false,
            auto_hide = true,
            tabpages = false,
            icon_separator_active = "",
            icon_separator_inactive = "",
            icon_close_tab = "",
            icon_close_tab_modified = "●",
            icon_pinned = "車",
        })
    end,
}
