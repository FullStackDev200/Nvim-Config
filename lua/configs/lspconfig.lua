-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- typescript config
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Emmet
lspconfig.emmet_language_server.setup {
  filetypes = {
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "pug",
    "typescriptreact",
  },
  init_options = {
    includeLanguages = {},
    excludeLanguages = {},
    extensionsPath = {},
    preferences = {},
    showAbbreviationSuggestions = true,
    showExpandedAbbreviation = "always",
    showSuggestionsAsSnippets = false,
    syntaxProfiles = {},
    variables = {},
  },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Clangd setup
lspconfig.clangd.setup {
  cmd = { "clangd" }, -- If clangd is in your PATH, otherwise specify the full path
  filetypes = { "c", "cpp", "objc", "objcpp" }, -- Files clangd should work with
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"), -- Change this if you have different root patterns
  settings = {
    clangd = {
      fallbackFlags = { "-std=c++17" }, -- Modify this if needed, e.g., for newer C++ standards
    },
  },
  on_attach = function(client, bufnr)
    -- Keybindings and custom configurations can be added here
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- Add more mappings as needed
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(), -- Optional, if you're using nvim-cmp for autocompletion
}

-- Pyright setup for Python
lspconfig.pyright.setup {
  on_attach = function(client, bufnr)
    -- Configure keybindings and other settings here if needed
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  end,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- Options: off, basic, strict
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace", -- Options: openFilesOnly, workspace
      },
    },
  },
}
