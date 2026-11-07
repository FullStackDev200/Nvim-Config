
require('blink.cmp').setup({
  snippets = { preset = "luasnip" },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = {
    implementation = "prefer_rust",
    sorts = {
      "exact",
      "score",
      "sort_text",
    },
  },

  sources = {
    default = { "snippets", "lsp", "buffer", "path" },
    providers = {
      buffer = {
        opts = {
          -- Completion from other open buffers
          get_bufnrs = function()
            return vim.tbl_filter(function(bufnr)
              return vim.bo[bufnr].buftype == ''
            end, vim.api.nvim_list_bufs())
          end
        }
      },
      lsp = {
        override = {get_trigger_characters = function(self)
          local trigger_characters = self:get_trigger_characters()
          vim.list_extend(trigger_characters, { '\n', '\t', ' ' })
          return trigger_characters
        end
      }
    },

    cmdline = {
      -- ignores cmdline completions when executing shell commands
      enabled = function()
        return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
      end
    }
  },
  min_keyword_length = 2,
},

keymap = {
  preset = "default",
  ["<CR>"] = { "accept", "fallback" },
},

completion = {
  ghost_text = { enabled = true },
  documentation = {
    auto_show = false,
    auto_show_delay_ms = 200,
    window = { border = "single" },
  },

  -- by default, blink.cmp will block newline, tab and space trigger characters, disable that behavior
  trigger = { show_on_blocked_trigger_characters = {} },
},
})
