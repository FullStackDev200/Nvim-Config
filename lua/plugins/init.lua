return {
  { import = "nvchad.blink.lazyspec" },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- TODO: Maybe change this once
        ghost_text = { enabled = false },
      },
      fuzzy = {
        sorts = {
          "exact",
          function(item_a, _)
            return item_a == "Snippet"
          end,
          "score",
          "sort_text",
        },
      },
      sources = {
        default = { "snippets", "lsp", "buffer", "path" },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim", -- media_files extension
      "jvgrootveld/telescope-zoxide",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require "configs.telescope"
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable "make" == 1,
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

  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     local cmp = require "cmp"
  --
  --     opts.mapping["<C-Space>"] = cmp.mapping.confirm {
  --       behavior = cmp.ConfirmBehavior.Insert,
  --       select = true,
  --     }
  --
  --     opts.mapping["<Tab>"] = nil
  --     opts.mapping["<S-Tab>"] = nil
  --
  --     -- 🧠 Add a new source without removing existing ones
  --     table.insert(opts.sources, { name = "emoji" })
  --
  --     return opts
  --   end,
  -- },

  -- {
  --   "Badhi/nvim-treesitter-cpp-tools",
  --   ft = "cpp",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   -- Optional: Configuration
  --   opts = function()
  --     local options = {
  --       preview = {
  --         quit = "q", -- optional keymapping for quit preview
  --         accept = "<tab>", -- optional keymapping for accept preview
  --       },
  --       header_extension = "h", -- optional
  --       source_extension = "cpp", -- optional
  --       custom_define_class_function_commands = { -- optional
  --         TSCppImplWrite = {
  --           output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
  --         },
  --         --[[
  --               <your impl function custom command name> = {
  --                   output_handle = function (str, context)
  --                       -- string contains the class implementation
  --                       -- do whatever you want to do with it
  --                   end
  --               }
  --               ]]
  --       },
  --     }
  --     return options
  --   end,
  --   -- End configuration
  --   config = true,
  -- },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- Optional: UI for nvim-dap
      "theHamsta/nvim-dap-virtual-text", -- Optional: Virtual text support
    },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
      require "configs.dapconfig"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "echasnovski/mini.ai",
    lazy = false,
    version = "*",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require "configs.mini"
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
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
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
    "nvim-telescope/telescope-media-files.nvim",
    lazy = false,
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
}
