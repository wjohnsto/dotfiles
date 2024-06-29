local wezterm = require("wezterm")
local act = wezterm.action
local exports = {}

function exports:apply(config)
  local keys = {
    -- Move between tabs.
    { key = "1", mods = "LEADER",       action = act.MoveTab(1 - 1) },
    { key = "1", mods = "LEADER",       action = act.ActivateTab(1 - 1) },
    { key = "2", mods = "LEADER",       action = act.MoveTab(2 - 1) },
    { key = "2", mods = "LEADER",       action = act.ActivateTab(2 - 1) },
    { key = "3", mods = "LEADER",       action = act.MoveTab(3 - 1) },
    { key = "3", mods = "LEADER",       action = act.ActivateTab(3 - 1) },
    { key = "4", mods = "LEADER",       action = act.MoveTab(3 - 1) },
    { key = "4", mods = "LEADER",       action = act.ActivateTab(4 - 1) },
    { key = "5", mods = "LEADER",       action = act.MoveTab(5 - 1) },
    { key = "5", mods = "LEADER",       action = act.ActivateTab(5 - 1) },
    { key = "6", mods = "LEADER",       action = act.MoveTab(6 - 1) },
    { key = "6", mods = "LEADER",       action = act.ActivateTab(6 - 1) },
    { key = "7", mods = "LEADER",       action = act.MoveTab(7 - 1) },
    { key = "7", mods = "LEADER",       action = act.ActivateTab(7 - 1) },
    { key = "8", mods = "LEADER",       action = act.MoveTab(8 - 1) },
    { key = "8", mods = "LEADER",       action = act.ActivateTab(8 - 1) },
    { key = "9", mods = "LEADER",       action = act.MoveTab(9 - 1) },
    { key = "9", mods = "LEADER",       action = act.ActivateTab(9 - 1) },
    { key = "p", mods = "LEADER",       action = act.MoveTabRelative(-1) },
    { key = "p", mods = "LEADER",       action = act.ActivateTabRelative(-1) },
    { key = "n", mods = "LEADER",       action = act.MoveTabRelative(1) },
    { key = "n", mods = "LEADER",       action = act.ActivateTabRelative(1) },
    -- Create/close tabs.
    { key = "c", mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
    { key = "x", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
  }

  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end

  -- Tab bar
  config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  config.show_tab_index_in_tab_bar = true
  config.tab_bar_at_bottom = false
  config.show_new_tab_button_in_tab_bar = false
  config.use_fancy_tab_bar = false
  config.cursor_blink_ease_in = "Constant"
  config.cursor_blink_ease_out = "Constant"
  config.cursor_blink_rate = 0
end

return exports
