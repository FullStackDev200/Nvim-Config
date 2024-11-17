require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Keep at least 10 lines above and below the cursor
vim.o.scrolloff = 10
vim.opt.relativenumber = true
vim.opt.incsearch = true

-- Undotree longer undo
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
