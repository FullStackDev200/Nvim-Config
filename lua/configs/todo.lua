vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next { keywords = { "ERROR", "WARNING" } }
end, { desc = "Next error/warning todo comment" })
