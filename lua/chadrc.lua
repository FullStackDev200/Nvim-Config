-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  -- transparency = true,
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

M.ui = {
  cmp = {
    format_colors = {
      tailwind = true,
    },
  },

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    -- "                            ",
    -- "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
    -- "   ▄▀███▄     ▄██ █████▀    ",
    -- "   ██▄▀███▄   ███           ",
    -- "   ███  ▀███▄ ███           ",
    -- "   ███    ▀██ ███           ",
    -- "   ███      ▀ ███           ",
    -- "   ▀██ █████▄▀█▀▄██████▄    ",
    -- "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
    -- "                            ",
    -- "                            ",

    "⠀⠀⠀⠀⠀⠀⢸⣿⣿⣶⣤⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢀⡀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢸⣿⣶⣬⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⢰⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⡏⢲⣀⣤⣬⢹⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⢸⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⠂⠀⠈⢿⣿⣿⡇⢠⣿⠛⢻⢸⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⠀⢰⠈⣿⣿⣿⣿⣿⣿⣿⣿⠻⠦⡀⠀⣸⣿⣿⣿⣵⠈⠁⠘⢸⣿⣿⣿⣿⡁⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣦⡈⢠⣇⣀⣈⣉⣉⣛⡛⠛⠓⢶⠒⠚⠟⠟⠛⠛⠛⠒⠒⢚⣺⣏⣉⣡⣤⣧⡀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠰⣄⡀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡚⠙⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣀⠀⠀⠀",
    "⠀⠀⠀⠀⠙⢿⣾⣿⣿⣿⡿⠛⠻⣿⣿⣿⣯⠑⠐⠚⠷⣶⣭⡛⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣀",
    "⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⢇⠤⣄⠈⢿⣿⠀⠀⢩⣶⡶⣾⣿⣿⣿⣶⣦⣤⣭⣍⠟⢛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⢠⣶⣿⣿⣿⣿⣿⣿⣿⣿⠀⠐⡯⠃⢸⡇⠀⠀⠈⠙⠛⠷⠚⠀⠀⠉⠉⠉⠉⠁⠀⡎⠈⠿⠿⠿⠭⢿⠛⡻⢿⣿⣿⣿⠛⠛⠿⠿⠿⠛",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⢠⣠⠈⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣼⡇⠀⠀⠀⠀⠀⠀⢠⠃⢈⣿⡿⠟⠀⠀⠀⠀⠀⠀",
    "⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢦⡟⢧⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⢿⡀⠀⠀⠀⠀⢀⡎⠀⣾⠉⠀⠀⠀⠀⠀⠀⠀⠀",
    "⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡇⠀⠀⠙⠦⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀⠀⠀⠀⣼⣀⠀⠙⠦⠀⠀⢀⣤⠶⠚⠛⠛",
    "⣿⣿⣿⣿⣿⣿⣿⠃⠹⣿⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⢀⠔⠋⠀⠀⠀⣰⠻⢿⣿⣦⣤⡀⣰⣿⣇⠀⢀⣀⣀",
    "⣿⣿⣿⣿⣿⣿⡿⠀⠀⠸⠀⠀⡄⠀⠀⠀⣧⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⢀⣀⣀⣀⡀⠀⠀⠀⣸⡏⠙⠢⡙⢿⣿⣿⠿⠛⠋⡴⠋⠁⠀",
    "⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⣄⠀⠀⠀⠀⠀⠀⠀⠘⣇⣀⣀⡈⠙⠀⠀⣼⠯⠀⠀⠀⠉⠢⢍⣻⡄⠀⢸⣷⣤⣀⠀",
    "⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠧⠤⠤⠀⠀⠀⠀⠀⠉⢧⡀⢸⣿⣿⣿⣶",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⢸⡀⠀⠀⠀⠀⠘⣿⣿⣿⣦⣀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠉⠉⠛⠀⠀⠀⠀⠀⢠⣶⠄⣉⠉⠇⢹⣿⡿",
    "⣿⣿⣿⡿⠿⠿⢿⣿⣿⣿⣿⣷⣤⡇⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣷⣤⡀⢀⣀⣠⣤⡟⢡⡀⠐⣒⡂⠀⠀⠀⢠⡿⠀⠈⢻⡷⣦⣿⠟⢢",
    "⣿⣿⣿⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⢋⡟⠉⠁⠀⠀⠙⢷⣄⠈⠆⠀⠀⢯⢀⣀⣠⠋⣴⣿⣏⠀⡸",
    "⣿⣿⣿⣄⡀⢀⡔⠉⠀⠀⠙⣿⣿⣿⣿⣿⠏⠑⠀⠀⠀⠈⢿⣿⠟⠉⢀⡜⠀⠀⠀⢠⠀⠀⠈⠿⡛⢦⣄⠀⠀⠀⠙⠢⣾⣿⢧⡤⠞⠁",
    "⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⣸⣿⣿⡿⠃⡀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠋⠀⠀⠀⢠⠇⠀⠀⡸⠀⠱⡀⠉⠳⣄⠀⠊⣸⣿⠁⠀⠀⠀⠀",
    "⣿⣿⣿⣿⣿⣿⣦⣀⣀⣠⣶⣿⣿⡿⠁⠀⠑⣄⠀⠀⠀⠀⠀⢠⠋⠀⠀⠀⣀⠔⠁⠀⠀⣴⠃⠀⠀⠙⣄⠀⠈⠙⢶⣿⠋⢑⠖⠒⠒⠒",
    "     Powered By  eovim    ",
    "                            ",
  },
  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰍕 Restore session", keys = "re", cmd = "SessionRestore" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}
return M
