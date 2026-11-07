local map = vim.keymap.set
local unmap = vim.keymap.del

-----  Terminal esc
map("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true })
map("n", "<Esc>", "<cmd>noh<CR>", { silent = true })

-----  Delete without affecting the default register
map(
  { "n", "x" },
  "<leader>d",
  '"_d',
  { noremap = true, silent = true, desc = "Delete without affecting default register" }
)

-----  Save with formatting
vim.api.nvim_create_user_command("W", function()
  vim.lsp.buf.format({ async = true })

  vim.cmd("write")
  vim.notify("File saved with LSP formatting", vim.log.levels.INFO)
end, { desc = "Format and save file" })


-----  Indent settings for visual mode
map("x", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" })
map("x", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" })

-----  Primeagen settings for smoother scrolling and movement
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
map("n", "n", "nzzzv", { desc = "Search forward and center cursor" })
map("n", "N", "Nzzzv", { desc = "Search backward and center cursor" })

----- X to void register
map("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete character under cursor" })


----- Better / in visual mode
map("x", "/", [["zy/<C-r>z<CR>]], { noremap = true })

----- Buffers
local function new_scratch_buffer(cmd, buflisted)
  if cmd then
    vim.cmd(cmd) -- "split" or "vsplit"
  end

  local buf = vim.api.nvim_create_buf(buflisted, true) -- scratch, nofile
  vim.api.nvim_win_set_buf(0, buf)
end

-- current window
map("n", "<leader>bb", function()
  new_scratch_buffer("", true)
end, { desc = "Scratch buffer (current window)" })

-- horizontal split
map("n", "<leader>bs", function()
  new_scratch_buffer("split", false)
end, { desc = "Scratch buffer (horizontal split)" })

-- vertical split
map("n", "<leader>bv", function()
  new_scratch_buffer("vsplit", false)
end, { desc = "Scratch buffer (vertical split)" })

map("n", "<leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete buffer" })

map("n", "<leader>bh", "<Cmd>lua MiniBufremove.unshow()<CR>", { desc = "Hide buffer" })

-----  Paste with visual selection or normal mode
map("n", "<A-v>", "<C-v>", { desc = "Paste from clipboard" })

map("n", "<leader><leader>x", ":source %<CR>", { desc = "Execute current file<CR>", noremap = true, silent = true })

----- Command to remove carriage returns
vim.api.nvim_create_user_command("RemoveCarriageReturns", function()
  vim.fn.execute [[%s/\r//g]]
end, { desc = "Remove carriage returns from the buffer" })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    local _ = pcall(function()
      vim.cmd "RemoveCarriageReturns"
    end)
  end,
})

----- Add position before entering visual mode to jumplist
local function mark_and_visual(key)
  return function()
    vim.cmd("normal! m'")
    local k = vim.api.nvim_replace_termcodes(key, true, false, true)
    vim.api.nvim_feedkeys(k, 'n', false)
  end
end

map('n', 'v', mark_and_visual('v'), { noremap = true })
map('n', 'V', mark_and_visual('V'), { noremap = true })
map('n', '<C-v>', mark_and_visual('<C-v>'), { noremap = true })

----- Git remaps
local gitsigns = require "gitsigns"

-- Text object
map({ "o", "x" }, "ih", gitsigns.select_hunk)
map({ "o", "x" }, "ah", gitsigns.select_hunk)

map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    require("gitsigns").nav_hunk "next"
  end
end)

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    require("gitsigns").nav_hunk "prev"
  end
end)

map("n", "<leader>gr", function()
  gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Reset Hunk" })

map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this file" })

map("n", "<leader>gp", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })
map("n", "<leader>gi", gitsigns.preview_hunk, { desc = "Preview Hunk" })

----- Lsp remaps
map("n", "<leader>ld", require("telescope.builtin").lsp_document_symbols, { desc = "Show document symbols" })
map("n", "<leader>lw", require("telescope.builtin").lsp_workspace_symbols, { desc = "Show workspace symbols" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

----- Telescope mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope Files" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Regex" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Regex" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Regex" })
map("n", "<leader>fm", "<cmd>Telescope keymaps<CR>", { desc = "Telescope Mappings" })
map("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git Commits" })
map("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git Status" })
map("n", "<leader>fW", "<cmd>Telescope grep_string<CR>", { desc = "Telescope word under cursor" })

----- Toggles
----- From mini.basics
local toggle_prefix = "\\"

local map_toggle = function(lhs, rhs, desc)
  map("n", toggle_prefix .. lhs, rhs, { desc = desc })
end

map_toggle(
  "g",
  '<Cmd>lua vim.print((require("gitsigns").toggle_signs() and "  " or "no") .. "gitsigns")<CR>',
  "Toggle 'Gitsigns'"
)

local blink = require "blink.cmp"
local config = require('blink.cmp.config')

map_toggle("t", function()
  local isToggled = config.completion.ghost_text.enabled
  config.completion.ghost_text.enabled = not isToggled
  blink.setup(config)
  vim.notify((not isToggled and "  " or "no") .. "ghost_text")
end, "Toggle autocomplete")

----- Luasnip
map("n", "*", function()
  vim.cmd "keepjumps normal! *N"
end, { silent = true })

map({ "i", "s" }, "<C-j>", function()
  require("luasnip").jump(1)
end, { silent = true })

map({ "i", "s" }, "<C-k>", function()
  require("luasnip").jump(-1)
end, { silent = true })

map({ "i", "s" }, "<C-l>", function()
  require("luasnip").change_choice(1)
end)

map({ "i", "s" }, "<C-h>", function()
  require("luasnip").change_choice(-1)
end)
