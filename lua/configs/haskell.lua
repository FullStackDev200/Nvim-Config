vim.g.haskell_tools = {
  tools = {
    repl = {
      ---@type haskell-tools.repl.Handler | (fun():haskell-tools.repl.Handler) `'builtin'`: Use the simple builtin repl. `'toggleterm'`: Use akinsho/toggleterm.nvim.
      handler = "toggleterm",
      ---@type haskell-tools.repl.Backend | (fun():haskell-tools.repl.Backend) Prefer cabal or stack when both stack and cabal project files are present?
      prefer = function()
        return vim.fn.executable "stack" == 1 and "stack" or "cabal"
      end,
      ---@class haskell-tools.repl.builtin.Config Configuration for the builtin repl
      builtin = {
        ---@type fun(view:haskell-tools.repl.View):fun(mk_repl_cmd:mk_ht_repl_cmd_fun) How to create the repl window. Should return a function that calls one of the `ReplView`'s functions.
        create_repl_window = function(view)
          return view.create_repl_split { size = vim.o.lines / 3 }
        end,
      },
      ---@type boolean | nil Whether to auto-focus the repl on toggle or send. If unset, the handler decides.
      auto_focus = true,
    },
  },
}
