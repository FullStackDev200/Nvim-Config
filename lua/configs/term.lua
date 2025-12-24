function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<A-c>", [[<C-\><C-n><Cmd>close<CR>A]], opts)
  vim.keymap.set("n", "<A-c>", [[<Cmd>:q<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
