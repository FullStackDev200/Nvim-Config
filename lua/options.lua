require "nvchad.options"

-- add yours here!

-- Keep at least 10 lines above and below the cursor
vim.o.scrolloff = 10
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.conceallevel = 1 -- Adjust the value as needed (0, 1, or 2)

vim.o.exrc = true
vim.o.secure = true

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shell = "powershell.exe"
  vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellquote = '"'
  vim.opt.shellxquote = ""
end

-- vim.opt.list = true
-- vim.opt.listchars = {
--   eol = "↴", -- Icon for line breaks
--   tab = "→ ", -- Icon for tabs
--   space = "·", -- Icon for spaces
--   trail = "•", -- Icon for trailing spaces
--   extends = "…", -- Icon for overflowing lines
--   precedes = "…", -- Icon for wrapped lines
-- }
