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

    local _, _, window = mux.spawn_window({ workspace = "default", cwd = wezterm.home_dir, args = args })
    mux.set_active_workspace("default")
    window:gui_window():maximize()
  end)

  -- Used for zenmode, see zenmode.lua
  wezterm.on("user-var-changed", function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
      local incremental = value:find("+")
      local number_value = tonumber(value)
      if incremental ~= nil then
        while number_value > 0 do
          window:perform_action(wezterm.action.IncreaseFontSize, pane)
          number_value = number_value - 1
        end
        overrides.enable_tab_bar = false
      elseif number_value < 0 then
        window:perform_action(wezterm.action.ResetFontSize, pane)
        overrides.font_size = nil
        overrides.enable_tab_bar = true
      else
        overrides.font_size = number_value
        overrides.enable_tab_bar = false
      end
    end
    window:set_config_overrides(overrides)
  end)
end

return exports
