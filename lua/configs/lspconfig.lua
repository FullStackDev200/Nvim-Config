require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "emmet_language_server",
  "cssls",
  "ts_ls",
  "lua_ls",
  "gopls",
  "clangd",
}
vim.lsp.config("clangd", {
  filetype = { "c", "cpp" },
  cmd = {
    "clangd",
    "--compile-commands-dir=build",
    "--query-driver=C:/ProgramData/mingw64/mingw64/bin/c++.exe",
    "--log=verbose",
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == "clangd" then
      local bufnr = args.buf
      vim.keymap.set(
        "n",
        "<leader>ls",
        ":LspClangdSwitchSourceHeader<CR>",
        { desc = "Switch between source/header", buffer = bufnr }
      )
    end
  end,
})

vim.lsp.enable(servers)
