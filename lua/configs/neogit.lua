local neogit = require("neogit")

vim.keymap.set(
    "n",
    "<leader>gg",
    function() neogit.open({ kind = "replace" }) end,
    { desc = "Open Neogit UI" }
)
