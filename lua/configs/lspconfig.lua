-- load defaults i.e lua_lsp

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "lua_ls", "clangd" }
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
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=bundled",
    "--function-arg-placeholders=false",
    "--fallback-style=llvm",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" }, -- Files clangd should work with
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"), -- Change this if you have different root patterns
  settings = {
    clangd = {
      fallbackFlags = { "-std=c++17" }, -- Modify this if needed, e.g., for newer C++ standards
    },
  },

  on_attach = nvlsp.on_attach,

  capabilities = require("cmp_nvim_lsp").default_capabilities(), -- Optional, if you're using nvim-cmp for autocompletion
}

vim.api.nvim_create_autocmd("LspAttach", {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" }, -- Apply only to C/C++ files
  -- Clangd-specific mappings
  callback = function(args)
    vim.keymap.set(
      "n",
      "<leader>ch",
      "<cmd>ClangdSwitchSourceHeader<CR>",
      { noremap = true, silent = true, buffer = args.buf }
    )
  end,
})

-- Pyright setup for Python
lspconfig.pyright.setup {
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

-- lspconfig.lua_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--       },
--       diagnostics = {
--         globals = { "vim" }, -- To prevent warnings about global `vim`
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false,
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }

vim.lsp.enable "lua_ls"
