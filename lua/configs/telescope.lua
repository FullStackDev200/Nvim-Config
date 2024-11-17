local telescope = require "telescope"
local z_utils = require "telescope._extensions.zoxide.utils"
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = { "themes", "terms" },
  extensions = {
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg",
    },
    zoxide = {
      prompt_title = "Change directory",
      mappings = {
        default = {
          after_action = function(selection)
            print("Update to (" .. selection.z_score .. ") " .. selection.path)
          end,
        },
        ["<C-s>"] = {
          before_action = function(selection)
            print "before C-s"
          end,
          action = function(selection)
            vim.cmd.edit(selection.path)
          end,
        },
        ["<C-q>"] = { action = z_utils.create_basic_command "split" },
        ["<C-b>"] = {
          keepinsert = true,
          action = function(selection)
            require("telescope").extensions.file_browser.file_browser { cwd = selection.path }
          end,
        },
      },
    },
    file_browser = {},
  },
}

-- Load both extensions
telescope.load_extension "media_files"
telescope.load_extension "zoxide"
telescope.load_extension "file_browser"
