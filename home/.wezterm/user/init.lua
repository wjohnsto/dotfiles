require("user.utils")
local colors = require("user.colors")
local copy = require("user.copy")
local events = require("user.events")
local fonts = require("user.fonts")
local launcher = require("user.launcher")
local panes = require("user.panes")
local search = require("user.search")
local set = require("user.set")
local tabs = require("user.tabs")
local workspaces = require("user.workspaces")

local exports = {}

function exports:apply(config)
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
end

return exports
