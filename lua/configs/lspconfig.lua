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
  on_attach = function(_, bufnr)
    vim.keymap.set({ "n", "i" }, "<leader>lh", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
  end,
})

vim.lsp.enable(servers)
