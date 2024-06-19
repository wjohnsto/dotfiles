local wezterm = require("wezterm")
local act = wezterm.action
local exports = {}

function exports:apply(config)
  local keys = {
    -- Search.
    { key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = " ", mods = "LEADER", action = wezterm.action.QuickSelect },
  }

  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end

  local key_tables = {
    search_mode = {
      { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
      { key = "n",      mods = "CTRL", action = act.CopyMode("NextMatch") },
      { key = "p",      mods = "CTRL", action = act.CopyMode("PriorMatch") },
      { key = "r",      mods = "CTRL", action = act.CopyMode("CycleMatchType") },
      { key = "u",      mods = "CTRL", action = act.CopyMode("NextMatchPage") },
      { key = "d",      mods = "CTRL", action = act.CopyMode("PriorMatchPage") },
    },
  }

  for _, key in ipairs(key_tables) do
    table.insert(config.key_tables, key)
  end
end

return exports
