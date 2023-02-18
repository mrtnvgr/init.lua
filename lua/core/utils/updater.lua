local create_command = vim.api.nvim_create_user_command

create_command("InitLuaUpdate", function()

    -- Update Self
    git.pull(false)

    -- Update Packer
    local status, packer = pcall(require, "packer")
    if not status then
        vim.api.nvim_err_writeln "Unable to access packer"
        return
    end
    vim.api.nvim_create_autocmd("User", {
        once = true,
        desc = "Close Packer window after update",
        pattern = "PackerComplete",
        callback = function()
            require("packer.display").quit()
        end,
    })
    packer.sync()

    -- Update Tree-sitter
    vim.cmd.TSUpdate()

    -- Update LSP
    initlua.mason.update_all()

end, { desc = "Update All Stuff" })
