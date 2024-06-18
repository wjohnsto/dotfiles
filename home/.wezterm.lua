local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_dirs = { "~/.fonts" }

config.font = wezterm.font_with_fallback({
  { family = "FiraMono Nerd Font", weight = "Medium" },
  { family = "icomoon",            weight = "Medium" },
})

config.color_scheme = "tokyonight_moon"

config.automatically_reload_config = true

return config
