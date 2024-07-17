local wezterm = require("wezterm")
local exports = {}

function exports:apply(config)
  config.font_dirs = { "~/.fonts" }
  config.font = wezterm.font_with_fallback({
    { family = "FiraMono Nerd Font Mono", weight = "Regular" },
    { family = "icomoon",                 weight = "Medium" },
  })
end

return exports
