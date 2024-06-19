local wezterm = require("wezterm")
local wjohnsto = require("wjohnsto")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.keys = {}
config.key_tables = {}

wjohnsto:apply(config)

return config
