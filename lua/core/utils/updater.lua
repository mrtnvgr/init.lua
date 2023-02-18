local create_command = vim.api.nvim_create_user_command

create_command("InitLuaUpdate", function()

    -- Update Self
    git.pull(false)

    -- Update Packer
    initlua.packer.update()

    -- Update Tree-sitter
    vim.cmd.TSUpdate()

    -- Update LSP
    initlua.mason.update_all()

end, { desc = "Update All Stuff" })
