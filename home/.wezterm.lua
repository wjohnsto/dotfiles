local wezterm = require("wezterm")
local user = require("user")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.keys = {}
config.key_tables = {}

user:apply(config)

return config
