local path = "lua/devil/core/mappings.lua"
local f = io.open(path, "r")
if not f then
  io.stderr:write("Cannot read " .. path .. "\n")
  os.exit(2)
end

local lines = {}
for line in f:lines() do
  table.insert(lines, line)
end
f:close()

local current_section = nil
local current_mode = nil
local section_depth = 0
local mode_depth = 0
local keys = {}

local function brace_delta(line)
  local opens = 0
  local closes = 0
  for _ in line:gmatch("{") do
    opens = opens + 1
  end
  for _ in line:gmatch("}") do
    closes = closes + 1
  end
  return opens - closes
end

for idx, line in ipairs(lines) do
  local section = line:match("^M%.([%w_]+)%s*=%s*{")
  if section then
    current_section = section
    section_depth = 1
    current_mode = nil
    mode_depth = 0
  elseif current_section then
    local mode = line:match("^%s*([nvisxoct])%s*=%s*{")
    if mode then
      current_mode = mode
      mode_depth = 1
    end
  end

  if current_section and current_mode then
    local lhs = line:match('^%s*%["([^"]+)"%]%s*=')
    if lhs then
      local k = current_mode .. "::" .. lhs
      keys[k] = keys[k] or {}
      table.insert(keys[k], { section = current_section, line = idx })
    end
  end

  local delta = brace_delta(line)
  if current_mode then
    mode_depth = mode_depth + delta
    if mode_depth <= 0 then
      current_mode = nil
      mode_depth = 0
    end
  end

  if current_section then
    section_depth = section_depth + delta
    if section_depth <= 0 then
      current_section = nil
      section_depth = 0
      current_mode = nil
      mode_depth = 0
    end
  end
end

local allow = {
  ["n::<leader>ca"] = true, -- intentionally repeated across LSP scopes
  ["n::<C-h>"] = true, -- bufferline/smart-splits coexist by design
  ["n::<C-l>"] = true, -- bufferline/smart-splits coexist by design
}

local conflicts = {}
for combo, refs in pairs(keys) do
  if #refs > 1 and not allow[combo] then
    table.insert(conflicts, { combo = combo, refs = refs })
  end
end

table.sort(conflicts, function(a, b)
  return a.combo < b.combo
end)

if #conflicts == 0 then
  print("Keymap conflict check: no unexpected conflicts")
  os.exit(0)
end

io.stderr:write("Keymap conflict check failed:\n")
for _, item in ipairs(conflicts) do
  io.stderr:write("  " .. item.combo .. "\n")
  for _, ref in ipairs(item.refs) do
    io.stderr:write(("    - section=%s line=%d\n"):format(ref.section, ref.line))
  end
end
os.exit(1)
