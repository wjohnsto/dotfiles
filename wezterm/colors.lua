local exports = {}

function exports:apply(config)
  config.color_scheme = "carbonfox"
  config.window_frame = {
    active_titlebar_bg = "#161616"
  }
end

return exports
