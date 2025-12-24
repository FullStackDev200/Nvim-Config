-- ~/.config/nvim/after/ftplugin/haskell.lua
local ht = require "haskell-tools"
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts)
vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts)
vim.keymap.set({ "n", "i", "t" }, "<A-c>", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)

-- Terminal mode mapping
vim.keymap.set("t", "<A-c>", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)

vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts)

-- ht.setup {}
