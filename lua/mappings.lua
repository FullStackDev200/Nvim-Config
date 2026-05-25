require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

-----  Keyboard users
map("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-----  Terminal esc
map("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true })

-----  Mouse users + NvimTree users
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-----  Delete without affecting the default register
map(
  { "n", "x" },
  "<leader>d",
  '"_d',
  { noremap = true, silent = true, desc = "Delete without affecting default register" }
)

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

----- Better j and k
map("n", "j", function()
  local count = vim.v.count

  if count == 0 then
    return "gj"
  else
    return "j"
  end
end, { expr = true })

map("n", "k", function()
  local count = vim.v.count

  if count == 0 then
    return "gk"
  else
    return "k"
  end
end, { expr = true })

-----
-----  [[My remaps]]
-----

----- X to void register
map("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete character under cursor" })

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

----- Tab switch from tabufline
for i = 1, 9, 1 do
  map("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

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

----- Save without formatting
vim.api.nvim_create_user_command("W", function()
  vim.cmd "noautocmd w"
end, { desc = "Save without formatting" })

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

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

----- Telescope mappings
if vim.loop.os_uname().sysname == "Windows_NT" then
  map("n", "<leader>ff", function()
    require("fff").find_files()
  end, { desc = "FFFind files" })
  map("n", "<leader>fw", function()
    require("fff").live_grep()
  end, { desc = "LiFFFe grep" })
  map("n", "<leader>fz", function()
    require("fff").live_grep { grep = { modes = { "fuzzy", "plain" } } }
  end, { desc = "Live fffuzy grep" })
  map("n", "<leader>fc", function()
    require("fff").live_grep { query = vim.fn.expand "<cword>" }
  end, { desc = "Search current word" })
  map("n", "<leader>fh", "<cmd>Pick help<CR>", { desc = "pick help page" })
  map("n", "<leader>fb", "<cmd>Pick buffers<CR>", { desc = "pick buffers" })
  map("n", "<leader>fo", "<cmd>Pick oldfiles<CR>", { desc = "telescope find oldfiles" })
else
  map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
  map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
  map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
  map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
  map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
  map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
  map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
  map("n", "<leader>fm", "<cmd>Telescope keymaps<CR>", { desc = "Telescope mappings" })
  map("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
  map("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })
  map("n", "<leader>fW", function()
    require("telescope.builtin").live_grep {
      default_text = vim.fn.expand "<cword>",
    }
  end, { desc = "Grep word under cursor" })
  map("n", "<leader>ft", "<Cmd>TodoTelescope<CR>", { desc = "Search Todos" })
  map("n", "<leader>ld", require("telescope.builtin").lsp_document_symbols, { desc = "Show document symbols" })
  map("n", "<leader>lw", require("telescope.builtin").lsp_workspace_symbols, { desc = "Show workspace symbols" })
end

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
local cmp = require "cmp"

map_toggle("a", function()
  vim.print(cmp.get_config().completion.autocomplete)
  if cmp.get_config().completion.autocomplete then
    cmp.setup { completion = { autocomplete = false } }
    print "noautocomplete"
  else
    cmp.setup { completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } }
    print "  autocomplete"
  end
end, "Toggle autocomplete")

----- Deleted keymaps
unmap("n", "s")
unmap("n", "<leader>b")
unmap("n", "<leader>x")
unmap("n", "<leader>gt")
unmap("n", "<leader>ma")
unmap("n", "<leader>cm")
unmap("n", "<leader>pt")

----- Getting used to nvim natives
map("n", "<leader>/", function()
  vim.print "Use gc instead"
end)
