local wezterm = require("wezterm")
local act = wezterm.action
local exports = {}

function exports:apply(config)
  local keys = {
    -- Launcher.
    { key = "s", mods = "LEADER", action = act.ShowLauncher },
    { key = "n", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(1) },
    { key = "p", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
  }

  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end
end

return exports
