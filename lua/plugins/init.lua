return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
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
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
      require "configs.dapconfig"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.dapconfig"
    end,
  },

  {
    "echasnovski/mini.ai",
    event = "InsertEnter",
    version = "*",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require "configs.mini"
    end,
  },

  {
    "echasnovski/mini.surround",
    event = "InsertEnter",
    version = "*",
    config = function()
      require("mini.surround").setup()
    end,
  },

  {
    "echasnovski/mini.operators",
    event = "InsertEnter",
    version = "*",
    config = function()
      require("mini.operators").setup()
    end,
  },

  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "configs.harpoon"
    end,
    keys = require "configs.harpoon",
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
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    config = true,
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
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
}
