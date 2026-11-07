require('blink.cmp').setup({
  snippets = { preset = "luasnip" },
  cmdline = { enabled = true },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = { 
    implementation = "prefer_rust",
    sorts = {
      "exact",
      "score",
      "sort_text",
    },
  },
  sources = { default = { "snippets", "lsp", "buffer", "path" } },

  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },

  completion = {
    ghost_text = { enabled = true },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 200,
      window = { border = "single" },
    },

    -- from nvchad/ui plugin
    -- exporting the ui config of nvchad blink menu
    -- helps non nvchad users
    -- menu = require("nvchad.blink").menu,
  },
})
