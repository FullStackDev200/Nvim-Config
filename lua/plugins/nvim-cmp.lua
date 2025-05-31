return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"

    opts.mapping["<C-Space>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }

    opts.mapping["<Tab>"] = nil
    opts.mapping["<S-Tab>"] = nil

    return opts
  end,
}
