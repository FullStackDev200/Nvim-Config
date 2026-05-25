local function getBuffers()
  local bufs = {}
  local devicons = require("nvim-web-devicons")

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted and vim.bo[bufnr].buftype == "" then
      local name = vim.api.nvim_buf_get_name(bufnr)
      local display_name = name ~= "" and vim.fn.fnamemodify(name, ":.") or "[No Name]"
      local ext = vim.fn.fnamemodify(name, ":e")
      local icon, hl = devicons.get_icon(name, ext, { default = true })

      table.insert(bufs, {
        bufnr    = bufnr,
        name     = display_name,
        icon     = icon or "",
        hl       = hl or "Normal",
        modified = vim.bo[bufnr].modified,
      })
    end
  end

  return bufs
end

local function openBufferList(buffers)
  local listbuf = vim.api.nvim_create_buf(false, true)

  vim.bo[listbuf].buftype  = "nofile"
  vim.bo[listbuf].bufhidden = "wipe"
  vim.bo[listbuf].swapfile = false
  vim.bo[listbuf].modifiable = true

  local width  = math.floor(vim.o.columns * 0.4)
  local height = math.floor(vim.o.lines * 0.4)
  local row    = math.floor((vim.o.lines - height) / 2)
  local col    = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(listbuf, true, {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = "rounded",
  })

  local current_buf = vim.api.nvim_get_current_buf()
  local lines = {}

  for _, buf in ipairs(buffers) do
    local modified_marker = buf.modified and " ●" or ""
    table.insert(lines, string.format("%s  %s%s", buf.icon, buf.name, modified_marker))
  end

  vim.api.nvim_buf_set_lines(listbuf, 0, -1, false, lines)

  local ns = vim.api.nvim_create_namespace("bufferlist")

  for i, buf in ipairs(buffers) do
    local line      = i - 1
    local line_len  = #lines[i]
    local icon_len  = vim.fn.strlen(buf.icon) -- byte length, correct for multi-byte glyphs
    local is_active = buf.bufnr == current_buf

    -- full line background for active buffer
    if is_active then
      vim.api.nvim_buf_set_extmark(listbuf, ns, line, 0, {
        end_col  = line_len,
        hl_group = "CursorLine",
        hl_eol   = true,
        priority = 100,
      })
    end

    -- icon: use devicons highlight group
    vim.api.nvim_buf_set_extmark(listbuf, ns, line, 0, {
      end_col  = icon_len,
      hl_group = buf.hl,
      priority = 200,
    })

    -- filename: bold+distinct for active, dimmed for inactive
    vim.api.nvim_buf_set_extmark(listbuf, ns, line, icon_len + 2, {
      end_col  = line_len,
      hl_group = is_active and "Directory" or "Comment",
      priority = 200,
    })

    -- modified marker in a distinct color
    if buf.modified then
      local marker_start = line_len - #" ●"
      vim.api.nvim_buf_set_extmark(listbuf, ns, line, marker_start, {
        end_col  = line_len,
        hl_group = "DiagnosticWarn",
        priority = 300,
      })
    end
  end

  vim.bo[listbuf].modifiable = false
  vim.wo[win].winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual"

  return listbuf, win
end

local close_timer = nil
local list_win = nil

local function closeBufferList()
  if close_timer then
    close_timer:stop()
    close_timer:close()
    close_timer = nil
  end
  if list_win and vim.api.nvim_win_is_valid(list_win) then
    vim.api.nvim_win_close(list_win, true)
  end
  list_win = nil
end

local function showBufferList()
  closeBufferList()

  local buffers = getBuffers()
  if #buffers == 0 then return end

  local prev_win = vim.api.nvim_get_current_win()
  local _, win = openBufferList(buffers)
  list_win = win

  -- immediately return focus to the original window so the float is passive
  vim.api.nvim_set_current_win(prev_win)

  close_timer = vim.uv.new_timer()
  close_timer:start(200, 0, vim.schedule_wrap(function()
    closeBufferList()
  end))
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("BufferListPreview", { clear = true }),
  callback = function()
    if vim.bo.buftype ~= "" then return end
    -- ignore if this BufEnter was triggered by our own float closing
    if list_win and vim.api.nvim_win_is_valid(list_win) then return end
    showBufferList()
  end,
})

openBufferList(getBuffers())
