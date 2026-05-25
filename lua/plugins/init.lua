return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    enabled = not (vim.loop.os_uname().version:match("Windows") ~= nil),
    config = function()
     require "configs.telescope"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",

    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "nvim-mini/mini.nvim",
    version = false,
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require "configs.mini"
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  {
    "jinh0/eyeliner.nvim",
    event = "VeryLazy",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
        dim = true,
        max_length = 9999,
        disabled_filetypes = {},
        disabled_buftypes = {},
        default_keymaps = true,
        match = '[0-9a-zA-Z"]',
      }
    end,
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
    config = function()
      require "configs.diffview"
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("todo-comments").setup()
      dofile(vim.g.base46_cache .. "todo")
    end,
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      dofile(vim.g.base46_cache .. "neogit")
      vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Show Neogit UI" })
    end,
  },

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },

  {
    "mrcjkb/haskell-tools.nvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      require "configs.haskell"
    end,
  },

  { "akinsho/toggleterm.nvim", version = "*", config = require "configs.term" },

  {
    dir = "C:/Users/round/source/repos/Comp.nvim",
    lazy = false,
    config = function()
      require("Comp").setup()
    end,
  },

  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    opts = {
      debug = {
        enabled = true,
        show_scores = true,
      },
    },
    lazy = false, -- the plugin lazy-initialises itself
  }
}
