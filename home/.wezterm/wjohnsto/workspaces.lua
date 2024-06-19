local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local exports = {}

local function get_workspaces()
  local choices = {}
  local max_depth = 6

  -- Add existing workspaces to the list of choices.
  for _, name in pairs(mux.get_workspace_names()) do
    table.insert(choices, { label = name, id = name })
  end

  -- Keep track of added workspaces.
  local added = {}
  for _, choice in pairs(choices) do
    added[choice.label] = true
  end

  local function add_workspace(path, choice)
    if added[path] == nil then
      table.insert(choices, choice)
      added[path] = true
    end
  end

  local function add_path(path, depth, ignores)
    depth = depth == nil and 0 or depth

    if depth > max_depth or not Is_Dir(path) or Has_Value(path, ignores) then
      return
    end

    for _, name in ipairs(wezterm.read_dir(path)) do
      if Is_Dir(name) then
        if Is_Git(name) then
          add_workspace(path, { label = path, id = path })
          goto continue
        end

        add_path(name, depth + 1, ignores)
        ::continue::
      end
    end
  end

  -- Add pre-defined workspaces to the list of choices if they exist.
  local dirs = {
    {
      path = wezterm.home_dir .. "/src",
      ignores = { "node_modules", "GUI-DNS-changer-for-linux" },
    },
  }

  for _, dir in pairs(dirs) do
    add_path(dir.path, 0, dir.ignores)
  end

  table.sort(choices, function(a, b)
    return a.label < b.label
  end)

  return choices
end

local action = wezterm.action_callback(function(window, pane, id, label)
  if not id and not label then
    return
  end

  local workspace_exists = false
  for _, name in pairs(mux.get_workspace_names()) do
    if name == id then
      workspace_exists = true
      break
    end
  end

  if not workspace_exists then
    mux.spawn_window({ workspace = label, cwd = id  })
    wezterm.log_info("spawning window for " .. id .. ".")
  end

  window:perform_action(
    act.SwitchToWorkspace({
      name = label,
    }),
    pane
  )
end)

function exports:apply(config)
  local keys = {
    {
      key = "f",
      mods = "LEADER",
      -- Asks to select a workspace from a list of pre-defined and already existing workspaces.
      -- First, if the selected workspace does not already exist, spawn a window in it with
      -- a specifed cwd. Then, switch to the workspace.
      action = act.InputSelector({
        title = "Select workspace",
        choices = get_workspaces(),

        action = action,
      }),
    },
    {
      key = "w",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = wezterm.format({
          { Attribute = { Intensity = "Bold" } },
          { Foreground = { AnsiColor = "Fuchsia" } },
          { Text = "Enter name for new workspace" },
        }),
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:perform_action(
              act.SwitchToWorkspace({
                name = line,
              }),
              pane
            )
          end
        end),
      }),
    },
  }

  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end
end

return exports
