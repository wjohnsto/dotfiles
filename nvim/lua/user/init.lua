require("user.remap")
require("user.set")
require("user.lazy_init")
require("user.autocmd")

function R(name)
    require("plenary.reload").reload_module(name)
end

-- Easily print a table to vim console for debugging
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(table.unpack(objects))
end

---shortens path by turning apple/orange -> a/orange
---@param path string
---@param sep string path separator
---@param max_len integer maximum length of the full filename string
---@return string
function _G.shorten_path(path, sep, max_len)
  local len = #path
  if len <= max_len then
    return path
  end

  local segments = vim.split(path, sep)
  for idx = 1, #segments - 1 do
    if len <= max_len then
      break
    end

    local segment = segments[idx]
    local shortened = segment:sub(1, vim.startswith(segment, '.') and 2 or 1)
    segments[idx] = shortened
    len = len - (#segment - #shortened)
  end

  return table.concat(segments, sep)
end

vim.filetype.add({
    extension = {
        templ = 'templ'
    }
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
