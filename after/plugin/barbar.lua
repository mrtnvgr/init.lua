local status, barbar = pcall(require, "bufferline")
if not status then
    vim.api.nvim_err_writeln "Unable to access barbar.nvim"
    return
end

barbar.setup({
    auto_hide = true,

    tabpages = false,

    icon_separator_active = "",
    icon_separator_inactive = "",
    icon_close_tab = "",
    icon_close_tab_modified = "●",
    icon_pinned = "車",
})
