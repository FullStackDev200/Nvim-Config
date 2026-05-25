vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",

  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/jinh0/eyeliner.nvim",


  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",

})

require("configs.mini")
require("configs.telescope")
require("configs.eyeliner")
require("configs.blink")
require("configs.luasnip")
require("configs.lspconfig")
require("configs.treesitter")

