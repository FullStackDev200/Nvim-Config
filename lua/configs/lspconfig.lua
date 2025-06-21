-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

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

vim.lsp.config("nixd", {
  -- your other options as usual
  settings = {
    nixd = {
      formatting = {
        command = { "alejandra" },
      },
    },
  },
})

vim.lsp.enable(servers)
