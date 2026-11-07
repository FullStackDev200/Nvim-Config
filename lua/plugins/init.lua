vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

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
  "https://github.com/neogitorg/neogit",
  "https://github.com/sindrets/diffview.nvim",

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
require("configs.neogit")

