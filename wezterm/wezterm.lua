require("utils")
local wezterm = require("wezterm")
local colors = require("colors")
local copy = require("copy")
local events = require("events")
local fonts = require("fonts")
local launcher = require("launcher")
local panes = require("panes")
local search = require("search")
local set = require("set")
local tabs = require("tabs")
local workspaces = require("workspaces")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.keys = {}
config.key_tables = {}

colors:apply(config)
copy:apply(config)
events:apply()
fonts:apply(config)
launcher:apply(config)
panes:apply(config)
search:apply(config)
set:apply(config)
tabs:apply(config)
workspaces:apply(config)

return config
