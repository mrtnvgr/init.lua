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
    packer.sync()

    -- Update Tree-sitter
    vim.cmd.TSUpdate()

    -- Update LSP
    initlua.mason.update_all()

end, { desc = "Update All Stuff" })
