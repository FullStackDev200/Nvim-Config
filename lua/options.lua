local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = '● ',
  },
-- <<<<<<< HEAD
--   update_in_insert = false,
--   severity_sort = true,
--   float = {
--     focusable = true,
-- =======
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
-- >>>>>>> 36598e96fdf69e26d616cc2a9d9c9a3543bae283
    style = 'minimal',
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
  },
})


if is_windows then
  vim.g.clipboard = {
    name = 'win32yank',
    copy = { ['+'] = 'win32yank.exe -i --crlf', ['*'] = 'win32yank.exe -i --crlf' },
    paste = { ['+'] = 'win32yank.exe -o --lf', ['*'] = 'win32yank.exe -o --lf' },
    cache_enabled = 0,
  }
-- <<<<<<< HEAD

  -- Set shell to pwsh
  vim.opt.shell = "pwsh.exe"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
  vim.env.NO_COLOR = "1"
  vim.opt.errorformat:prepend "%-Gmake%.%#"
-- =======
-- >>>>>>> 36598e96fdf69e26d616cc2a9d9c9a3543bae283
end

vim.cmd.packadd("nvim.undotree")
require("vim._core.ui2").enable({})

vim.cmd.colorscheme("catppuccin")
