local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = 14
  local height = 10

  local col = vim.o.columns - 10
  local row = vim.o.lines - 15


  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)


  return { buf = buf, win = win }
end


local toggle_fileplorer = function()
  local files = vim.split(vim.fn.system("ls"), "\n", { trimempty = true })


  -- Set the processed lines in the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)

  local userfile = vim.fn.expand("<cword>")



  -- Create a buffer
  local userbuf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    userbuf = opts.buf
  else
    userbuf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end


  vim.keymap.set("n", "<Enter>", "<cmd>e " .. userfile .. "<CR>", { buffer = userbuf })

  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
  end
end



vim.api.nvim_create_user_command("Fileplorer", toggle_fileplorer, {})
