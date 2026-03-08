local Comp = {}

local state_file = vim.fn.stdpath "data" .. "/project_state.json"

local function get_root()
  return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
end
local function contains_dir(tbl, dir)
  for _, v in ipairs(tbl) do
    if v.dir == dir then
      return true
    end
  end
  return false
end

local function find_dir(tbl, dir)
  for _, v in ipairs(tbl) do
    if v.dir == dir then
      return v
    end
  end
  return {}
end

local function replace_table_with_key(tbl, dir, new_entry)
  local new_list = {}
  for _, v in ipairs(tbl) do
    if v.dir == dir then
      table.insert(new_list, new_entry) -- replace matched entry
    else
      table.insert(new_list, v)         -- keep everything else
    end
  end
  return new_list
end

---@class ProjectState
---@field dir string
---@field lsp_enabled boolean
---@field build_command string?

---Save project state
---@param state ProjectState
local function save_state(new_state)
  if not new_state then return end

  local state_list = {}

  local f = vim.uv.fs_open(state_file, "r", 438)
  if f then
    local stat = vim.uv.fs_fstat(f)
    local data = stat and vim.uv.fs_read(f, stat.size, 0)
    vim.uv.fs_close(f)

    if data and data ~= "" then
      local ok, result = pcall(vim.json.decode, data)
      if not ok then
        vim.notify("Failed to decode project state: " .. result, vim.log.levels.ERROR)
        return
      end
      state_list = result
    end
  end

  local new_state_list
  if contains_dir(state_list, new_state.dir) then
    new_state_list = replace_table_with_key(state_list, new_state.dir, new_state)
  else
    new_state_list = {}
    for k, v in pairs(state_list) do
      new_state_list[k] = v
    end
    table.insert(new_state_list, new_state)
  end

  local ok, encoded = pcall(vim.json.encode, new_state_list)
  if not ok or not encoded then
    vim.notify("Failed to encode project state", vim.log.levels.ERROR)
    return
  end

  local f2 = vim.uv.fs_open(state_file, "w", 438)
  if not f2 then
    vim.notify("Could not write file", vim.log.levels.ERROR)
    return
  end
  vim.uv.fs_write(f2, encoded, 0)
  vim.uv.fs_close(f2)
end

---Get project state
---@return ProjectState
local function get_state()
  local f = io.open(state_file, "r")
  if not f then
    return {}
  end

  local content = f:read "*a"
  f:close()
  return vim.json.decode(content) or {}
end

Comp.get_comp_command = function()
  local dir = get_root() or vim.fn.getcwd()
  local comp_list = get_state()
  vim.print(find_dir(comp_list, dir))
  return find_dir(comp_list, dir).build_command
end

---Set compilation command
Comp.set_comp_command = function()
  local cmd

  vim.ui.input({
    prompt = "Enter compile command:   ",
    completion = "dir",
  }, function(input)
    if input then
      cmd = input
    end
  end)

  local root = get_root() or vim.fn.getcwd()
  save_state {
    dir = root,
    lsp_enabled = false,
    build_command = cmd,
  }
end

---@class QuickfixEntry
---@field path string
---@field lnum number
---@field col number?
---@field type "E" | "W" | "I" | "N"
---@field text string

---Parse a single error line
---@param line string
---@return QuickfixEntry?
local function parse_error_line(line)
  -- Use :cc to jump if there is a single entry
  if line:len() == 0 then
    return {}
  end

  local path, lnum, col
  if vim.loop.os_uname().sysname == "Windows_NT" then
    path, lnum, col = line:match "^([^:\r\n]+):(%d+):(%d+):"
    -- vim.print(path)
    if path == nil then
      path, lnum, col = line:match "^([A-Za-z]:\\[^:]+):(%d+)$"
    end
  end

  if path then
    return {
      path = path,
      lnum = tonumber(lnum),
      col = col,
      text = "Error",
    }
  end

  return nil
end

---Parse multiple lines of compiler output
---@param output string
---@return QuickfixEntry[]
local function parse_compiler_output(output)
  local results = {}
  for line in output:gmatch "[^\r\n]+" do
    local parsed = parse_error_line(line)
    if parsed then
      table.insert(results, parsed)
    end
  end
  return results
end

Comp.state = {
  is_open = false,
  output_buf = nil,
  output_win = 0,
}

Comp.compile = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_win = vim.api.nvim_get_current_win()
  local output = vim.fn.system(Comp.get_comp_command())

  local buf = Comp.state.output_buf

  if not Comp.state.is_open then
    buf = vim.api.nvim_create_buf(false, true)

    Comp.state.output_win = vim.api.nvim_open_win(buf, false, {
      split = "below",
      win = 0,
      height = 12,
    })

    vim.keymap.set("n", "<CR>", function()
      local line = vim.api.nvim_get_current_line()
      local file, lnum, col = line:match "([^:]+):(%d+):?(%d*)"

      if file then
        vim.api.nvim_set_current_win(current_win)
        vim.cmd.edit(file)
        if lnum then
          vim.api.nvim_win_set_cursor(0, { tonumber(lnum), tonumber(col) or 0 })
        end
      end
    end, { buffer = buf })

    vim.bo[buf].modifiable = false

    Comp.state.is_open = true
    Comp.state.output_buf = buf
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
  vim.bo[buf].modifiable = false

  local qf_entries = parse_compiler_output(output)

  if qf_entries then
    -- Add items to quickfix list
    for _, entry in ipairs(qf_entries) do
      vim.fn.setqflist({
        {
          filename = entry.path,
          lnum = entry.lnum,
          col = entry.col,
          text = entry.text,
          type = entry.type,
        },
      }, "r")
    end
  end
end

Comp.setup = function()
  _G.Comp = Comp

  vim.api.nvim_create_autocmd("WinClosed", {
    callback = function(event)
      local win_id = tonumber(event.match)
      if win_id == Comp.state.output_win then
        Comp.state.is_open = false
      end
    end,
  })
end

return Comp
