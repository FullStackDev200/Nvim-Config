return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim", -- media_files extension
      "jvgrootveld/telescope-zoxide",              -- zoxide extension
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require "configs.telescope"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
    },
  },

  {
    "echasnovski/mini.ai",
    lazy = false,
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },

  {
    "echasnovski/mini.surround",
    version = "*",
    lazy = false,
    config = function()
      require("mini.surround").setup()
    end,
  },

  {
    "echasnovski/mini.operators",
    lazy = false,
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
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "/MyObsidian/Obsidian Vault/My_Vault*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/MyObsidian/Obsidian Vault/",
        },
      },
      ui = {
        enable = false,
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    opts = {},
  },

  {
    "rmagatti/auto-session",
    lazy = false,

    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      auto_restore = false,
    },
  },

  {
    "jinh0/eyeliner.nvim",
    keys = { "f", "t", "F", "T" },
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

  { "meznaric/key-analyzer.nvim", cmd = "KeyAnalyzer", opts = {} },

  {
    "nvim-telescope/telescope-media-files.nvim",
    lazy = false,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = false,
    build = 'make'
  }
}
