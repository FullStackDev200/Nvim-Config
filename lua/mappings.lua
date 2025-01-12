require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

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

-- Pressing 'jk' in insert mode to escape to normal mode
map("i", "jk", "<ESC>", { desc = "Escape to normal mode" })
map("i", "<C-w>", "<C-o>", { desc = "Toggle normal mode for one command" })
--
-- Undo with <C-z>
map("n", "<C-z>", "u", { desc = "Undo" })
map(
-- Delete without affecting the default register
  { "n", "x" },
  "<leader>d",
  '"_d',
  { noremap = true, silent = true, desc = "Delete without affecting default register" }
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
map("n", "<leader>p", '"1p', { desc = "Paste second to last thing" })

-- [[My remaps]]
--
--X to void register
map("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete character under cursor" })

-- Paste with visual selection or normal mode
map("n", "<A-v>", "<C-v>", { desc = "Paste from clipboard" })

map("n", "<leader>gm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })

map("n", "<leader><leader>x", ":source %<CR>", { desc = "Execute current file<CR>", noremap = true, silent = true })

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

-- Floaterminal
map("n", "<leader>st", ":Floaterminal<CR>", { desc = "Open floating terminal" })
--Git remaps
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open 3 split view" })

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

map("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Telescope file browser" })

map("n", "<leader>fz", function()
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  require("telescope").extensions.zoxide.list {
    attach_mappings = function(prompt_bufnr, _)
      -- Define action to take on selection
      --
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

map("n", "<leader>fm", ":Telescope keymaps<CR>", { desc = "Telescope mappings" })

--Deleted keymaps
map("n", "s", "<Nop>", { noremap = true, silent = true })
