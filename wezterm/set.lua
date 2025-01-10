local wezterm = require("wezterm")
local act = wezterm.action

local exports = {}

function exports:apply(config)
  local horizontalPadding = 0
  local verticalPadding = 0

  config.window_padding = {
    left = horizontalPadding,
    right = horizontalPadding,
    top = verticalPadding,
    bottom = verticalPadding,
  }
  config.window_decorations = "RESIZE"
  config.front_end = "OpenGL"
  config.scrollback_lines = 10000
  config.automatically_reload_config = true
  config.window_close_confirmation = "NeverPrompt"
  config.skip_close_confirmation_for_processes_named = {}
  config.disable_default_key_bindings = true
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

  local keys = {
    -- Leader fix: Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A.
    { key = "a",   mods = "LEADER|CTRL",         action = act.SendString("\x01") },
    { key = "F11", action = act.ToggleFullScreen },
    { key = 'L',   mods = 'CTRL',                action = wezterm.action.ShowDebugOverlay },
  }

  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end
end

return exports
