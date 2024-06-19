local wezterm = require("wezterm")
local act = wezterm.action
local exports = {}

function exports:apply(config)
  local keys = {
     -- Copy/paste.
    { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
    { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
  }

  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end
end

return exports
