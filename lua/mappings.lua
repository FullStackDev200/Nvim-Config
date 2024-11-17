require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- Mouse users + NvimTree users
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- Enter command mode from normal mode using semicolon
map("n", ";", ":", { desc = "CMD enter command mode" })
-- Pressing 'jk' in insert mode to escape to normal mode
map("i", "jk", "<ESC>", { desc = "Escape to normal mode" })
map("i", "<C-w>", "<C-o>", { desc = "Toggle normal mode for one command" })
--
-- Undo with <C-z>
map("n", "<C-z>", "u", { desc = "Undo" })
-- Delete without affecting the default register
map("n", ",d", "d", { noremap = true, silent = true, desc = "Delete without affecting default register" })
map(
  "x",
  ",d",
  "d",
  { noremap = true, silent = true, desc = "Delete without affecting default register in visual mode" }
)

-- Indent settings for visual mode
map("x", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" })
map("x", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" })

-- Primeagen settings for smoother scrolling and movement
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
map("n", "n", "nzzzv", { desc = "Search forward and center cursor" })
map("n", "N", "Nzzzv", { desc = "Search backward and center cursor" })
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting default register" })

-- [[My remaps]]
--
-- Delete without affecting the default register in normal and visual modes
map({ "x", "n" }, "d", '"_d', { desc = "Delete without affecting default register" })
-- Paste with visual selection or normal mode
map("n", "<A-v>", "<C-v>", { desc = "Paste from clipboard" })
-- Delete with leader key without affecting default register
map({ "x", "n" }, "<leader>d", "d", { desc = "Delete with leader key" })

-- Visual mode remaps for wrapping text in brackets
map("v", "<Space>", "<Nop>", { remap = false, desc = "Disable space in visual mode" })
map("v", "<leader>(", "<esc>`>a)<esc>`<i(<esc>", { remap = false, desc = "Wrap selection in parentheses" })
map("v", "<leader>{", "<esc>`>a}<esc>`<i{<esc>", { remap = false, desc = "Wrap selection in curly braces" })
map("v", "<leader>[", "<esc>`>a]<esc>`<i[<esc>gv", { remap = false, desc = "Wrap selection in square brackets" })
map("v", '<leader>"', '<esc>`>a"<esc>`<i"<esc>gv', { remap = false, desc = "Wrap selection in double quotes" })

--Tab switch from tabufline
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

-- Command to remove carriage returns
vim.api.nvim_create_user_command("RemoveCarriageReturns", function()
  vim.fn.execute [[%s/\r//g]]
end, { desc = "Remove carriage returns from the buffer" })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*", -- Runs for all files; you can specify file types if needed
  callback = function()
    local _ = pcall(function()
      vim.cmd "RemoveCarriageReturns" -- Call the command to remove carriage returns
    end)
  end,
})

local function surround()
  -- Prompt the user for input
  local openBracket = vim.fn.input "Surround with: "

  local bracketPair = {
    ["{"] = "}",
    ["["] = "]",
    ["("] = ")",
  }
  local closeBracket

  if string.find(openBracket, "/") ~= nil then
    local parts = {}
    for part in string.gmatch(openBracket, "([^/]+)") do
      table.insert(parts, part)
    end

    closeBracket = parts[2]
    openBracket = parts[1]
    print(openBracket)
  elseif openBracket == '"' then
    openBracket = '\\"'
    closeBracket = '\\"'
  else
    closeBracket = bracketPair[openBracket] or openBracket
  end

  -- Check if the openBracket is not empty
  if openBracket and openBracket ~= "" then
    -- Execute the commands to surround the selection
    vim.cmd('execute "normal! `>a' .. closeBracket .. "\\<Esc>`<i" .. openBracket .. '"')
  else
    print "No character entered!"
  end
end
-- Create a command to call the function (optional)
vim.api.nvim_create_user_command("Surround", surround, {})
-- Map the function to a key combination (optional)
map("n", "<leader>sr", ":Surround<CR>", { noremap = true, silent = true })
map("v", "<leader>sr", "<ESC>:Surround<CR>", { noremap = true, silent = true })

--
--Telescope mappings
--
local telescope = require "telescope"
map("n", "<leader>oo", function()
  require("telescope.builtin").find_files { cwd = "~/MyObsidian/Obsidian Vault/" }
end, { desc = "Open note from Obsidian" })

map("n", "<leader>on", function()
  require("telescope.builtin").find_files { cwd = "~/.config/nvim" }
end, { desc = "Open Neovim" })

map("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "telescope file browser" })

map("n", "<leader>fz", function()
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  require("telescope").extensions.zoxide.list {
    attach_mappings = function(prompt_bufnr, _)
      -- Define action to take on selection
      actions.select_default:replace(function()
        local selected_entry = action_state.get_selected_entry()
        local selected_path = selected_entry.path

        -- Close the Zoxide picker
        actions.close(prompt_bufnr)

        -- Change directory to the selected path
        vim.cmd("cd " .. selected_path)

        -- Open the Telescope file finder in the new directory
        require("telescope.builtin").find_files { cwd = selected_path }
      end)
      return true
    end,
  }
end)
