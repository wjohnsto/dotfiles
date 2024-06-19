require("wjohnsto.utils")
local colors = require("wjohnsto.colors")
local copy = require("wjohnsto.copy")
local events = require("wjohnsto.events")
local fonts = require("wjohnsto.fonts")
local launcher = require("wjohnsto.launcher")
local panes = require("wjohnsto.panes")
local search = require("wjohnsto.search")
local set = require("wjohnsto.set")
local tabs = require("wjohnsto.tabs")
local workspaces = require("wjohnsto.workspaces")

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
