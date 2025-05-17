-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "emmet_language_server",
  "cssls",
  "ts_ls",
  "lua_ls",
  "clangd",
  "nixd",
}
vim.lsp.config("clangd", {
  filetype = { "c", "cpp" },
})

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.nix" },
  callback = function()
    vim.cmd "%!alejandra --quiet"
  end,
})
