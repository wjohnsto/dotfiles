function Merge_Tables(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        Merge_Tables(t1[k] or {}, v or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end

  return t1
end

function Is_Git(path)
  local _, j = string.find(path, ".git")
  return j == string.len(path)
end

function Path_Exists(file)
  local f = io.open(file, "r")

  if not f then
    return false
  end

  local directory = not f:read(0) and f:seek("end") ~= 0

  f:close()

  return directory
end

function Has_Value(val, tab)
  if tab == nil or val == nil then
    return false
  end

  for _, value in ipairs(tab) do
    local _, j = string.find(val, value)

    if type(j) == "number" then
      return true
    end
  end

  return false
end

--- Check if a directory exists in this path
function Is_Dir(path)
  -- "/" works on both Unix and Windows
  return Path_Exists(path .. "/")
end
