require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
local servers = {
  "html",
  "emmet_language_server",
  "cssls",
  "ts_ls",
  "lua_ls",
  "clangd",
}
vim.lsp.config("clangd", {
  filetype = { "c", "cpp" },
})

vim.lsp.enable(servers)
