local spec_treesitter = require("mini.ai").gen_spec.treesitter

require("mini.ai").setup {
  custom_textobjects = {
    F = spec_treesitter { a = "@function.outer", i = "@function.inner" },
    o = spec_treesitter {
      a = "@block.outer", -- outer conditional (e.g., if statements)
      i = "@block.inner", -- inner conditional (e.g., the content of if statements)
    },
    g = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line "$",
        col = math.max(vim.fn.getline("$"):len(), 1),
      }
      return { from = from, to = to }
    end,
    a = spec_treesitter { a = "@parameter.outer", i = "@parameter.inner" },
  },
  search_method = "cover_or_nearest",
  n_line = 100,
}
