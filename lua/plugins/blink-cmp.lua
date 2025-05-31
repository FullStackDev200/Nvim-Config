if vim.loop.os_uname().sysname ~= "Windows_NT" then
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
  }
else
  return {}
end
