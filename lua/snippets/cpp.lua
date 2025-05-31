local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require "luasnip.extras.expand_conditions"
local postfix = require("luasnip.extras.postfix").postfix
local types = require "luasnip.util.types"
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

----------------------------------------------------------------------
--                             Printing                             --
----------------------------------------------------------------------
ls.add_snippets("cpp", {
  s("cout", fmt([[cout << "{}" << endl;]], { i(1, "out") })),
  s("cin", fmt([[cin >> {};]], { i(1, "variable") })),
})

----------------------------------------------------------------------
--                               SFML                               --
----------------------------------------------------------------------

vim.api.nvim_create_autocmd("BufAdd", {
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype

    if ft ~= "cpp" then
      return
    end

    vim.schedule(function()
      local search_text = "#include <SFML"
      local found = false
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      for _, line in ipairs(lines) do
        if line:find(search_text, 1, true) then -- plain match
          found = true
          break
        end
      end

      if found then
        require("luasnip").add_snippets("cpp", {
          s("sfr", fmt([[sf::RectangleShape {};]], { i(1, "recName") })),
        })
      end
    end)
  end,
})
