require "nvchad.mappings"

local map = vim.keymap.set

-----  Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-----  Terminal esc
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true })

-----  Mouse users + NvimTree users
vim.keymap.set("n", "<RightMouse>", function()
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
map("n", "<leader>p", '"1p', { desc = "Paste second to last thing" })

----- Window Navigation
map({ "n", "x" }, "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "switch window left" })
map({ "n", "x" }, "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "switch window right" })
map({ "n", "x" }, "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "switch window down" })
map({ "n", "x" }, "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "switch window up" })

map("i", "<C-h>", "<Esc><C-w>ha", { noremap = true, silent = true })
map("i", "<C-l>", "<Esc><C-w>la", { noremap = true, silent = true })
map("i", "<C-j>", "<Esc><C-w>ja", { noremap = true, silent = true })
map("i", "<C-k>", "<Esc><C-w>ka", { noremap = true, silent = true })

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

-----  Paste with visual selection or normal mode
map("n", "<A-v>", "<C-v>", { desc = "Paste from clipboard" })
map("n", "<leader><leader>x", ":source %<CR>", { desc = "Execute current file<CR>", noremap = true, silent = true })

----- Tab switch from tabufline
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
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

-- Save without formatting
vim.api.nvim_create_user_command("W", function()
  vim.cmd "noautocmd w"
end, { desc = "Save without formatting" })

----- Git remaps
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open 3 split view" })

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

----- Lsp remaps
map("n", "<leader>ld", require("telescope.builtin").lsp_document_symbols, { desc = "Show document symbols" })
map("n", "<leader>lw", require("telescope.builtin").lsp_workspace_symbols, { desc = "Show workspace symbols" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

----- Telescope mappings

map("n", "<leader>fm", ":Telescope keymaps<CR>", { desc = "Telescope mappings" })
map("n", "<leader>gm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })

----- Gitsigns
require("gitsigns").setup {
  on_attach = function()
    local gitsigns = require "gitsigns"

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk)
    map({ "o", "x" }, "ah", gitsigns.select_hunk)
  end,
}

----- Deleted keymaps
map("n", "s", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("n", "*", function()
  vim.cmd "keepjumps normal! *N"
end, { silent = true })
