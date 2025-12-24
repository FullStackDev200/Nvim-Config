require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "emmet_language_server",
  "cssls",
  "ts_ls",
  "lua_ls",
  "gopls",
  "clangd",
  "nixd",
  "svelte",
}

vim.lsp.config("clangd", {
  filetype = { "cpp" },
  cmd = {
    "clangd",
    "--compile-commands-dir=build",
    "--query-driver=C:/ProgramData/mingw64/mingw64/bin/g++.exe",
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

vim.lsp.config("emmet_language_server", {
  filetypes = { "html", "css" },
})

vim.lsp.config("svelte", {
  filetypes = { "svelte" },
})

vim.lsp.enable(servers)
