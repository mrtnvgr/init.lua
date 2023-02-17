local lsp_status, lsp_zero = pcall(require, "lsp-zero")
if not lsp_status then
    return
end

local lsp = lsp_zero.preset({
    name = "minimal",
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
})

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr}
  local bind = vim.keymap.set

  bind("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
end)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
