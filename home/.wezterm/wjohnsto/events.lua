local wezterm = require("wezterm")
local mux = wezterm.mux

local exports = {}

function exports:apply()
  wezterm.on("update-right-status", function(window, _)
    window:set_right_status(window:active_workspace())
  end)

  wezterm.on("gui-startup", function(cmd)
    -- allow `wezterm start -- something` to affect what we spawn
    -- in our initial window
    local args = {}
    if cmd then
      args = cmd.args
    end

    mux.spawn_window({ workspace = "default", cwd = wezterm.home_dir, args = args })
    mux.set_active_workspace("default")
  end)
end

return exports
