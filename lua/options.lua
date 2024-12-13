require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Keep at least 10 lines above and below the cursor
vim.o.scrolloff = 10
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.conceallevel = 1 -- Adjust the value as needed (0, 1, or 2)

-- Map the function to `n` for next search
vim.api.nvim_set_keymap("n", "n", ":lua search_and_notify()<CR>", { noremap = true, silent = true })
-- Undotree longer undo
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
