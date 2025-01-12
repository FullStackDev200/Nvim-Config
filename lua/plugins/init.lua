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
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            -- ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
      },
    },

  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",           -- Optional: UI for nvim-dap
      "theHamsta/nvim-dap-virtual-text" -- Optional: Virtual text support
    },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
      require("configs.dapconfig")
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    event = "VeryLazy",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },

  {
    "echasnovski/mini.ai",
    lazy = false,
    version = "*",
    dependencies = { "nvim-treesitter-textobjects" },
    config = function()
      require("configs.mini")
    end
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
    cmd = "Neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "configs.harpoon"
    end,
    keys = require "configs.harpoon",
  },

  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*", -- recommended, use latest release instead of latest commit
  --   ft = "markdown",
  --   event = {
  --     "BufReadPre " .. vim.fn.expand "~" .. "/MyObsidian/Obsidian Vault/My_Vault*.md",
  --   },
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "personal",
  --         path = "~/MyObsidian/Obsidian Vault/",
  --       },
  --     },
  --     ui = {
  --       enable = false,
  --     },
  --   },
  -- },


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
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    build = "make",
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    config = true
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
  }
}
