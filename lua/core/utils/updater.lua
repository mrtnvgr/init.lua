local create_command = vim.api.nvim_create_user_command

create_command("InitLuaUpdate", function()

    -- Update Self
    local pull_status, _ = git.pull(false)
    if pull_status then
        initlua.notify("InitLua: Repository pulled successfully")
    else
        vim.api.nvim_err_writeln "InitLua: Unable to pull repository"
    end

    -- Update Packer
    initlua.packer.update()

    -- Update Tree-sitter
    vim.cmd.TSUpdate()

    -- Update LSP
    initlua.mason.update_all()

end, { desc = "Update All Stuff" })
