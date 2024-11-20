local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local exports = {}
local git_project_home_dir = wezterm.home_dir .. "/src"

local function clean_workspace_name(name)
  name = name:gsub("* ", "")

  return name
end

local function remove_home_dir(name)
  name = name:gsub(git_project_home_dir, "")

  return name
end

local function get_workspaces()
  local choices = {}
  local max_depth = 6

  -- Add existing workspaces to the list of choices.
  for _, name in pairs(mux.get_workspace_names()) do
    local cname = clean_workspace_name(name)
    table.insert(choices, { label = "* " .. cname, id = git_project_home_dir .. cname })
  end

  -- Keep track of added workspaces.
  local added = {}
  local existing = {}
  for _, choice in pairs(choices) do
    added[choice.id] = true
    existing[choice.id] = true
  end

  local function add_workspace(choice)
    if added[choice.id] == nil then
      table.insert(choices, choice)
      added[choice.id] = true
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
          local short_path = remove_home_dir(path)
          add_workspace({ label = short_path, id = path })
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
      path = git_project_home_dir,
      ignores = { "node_modules" },
    },
  }

  for _, dir in pairs(dirs) do
    add_path(dir.path, 0, dir.ignores)
  end

  table.sort(choices, function(a, b)
    local ax = existing[a.id]
    local bx = existing[b.id]
    if ax == true and bx == false then
      return true
    end

    if ax == false and bx == true then
      return false
    end

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
    local cname = clean_workspace_name(name)
    if git_project_home_dir .. cname == id then
      workspace_exists = true
      break
    end
  end

  if not workspace_exists then
    local tab1, _, win = mux.spawn_window({ workspace = clean_workspace_name(label), cwd = id })
    tab1:set_title("editor")

    local tab2 = win:spawn_tab({ cwd = id })
    tab2:set_title("terminal")

    local tab3 = win:spawn_tab({ cwd = id })
    tab3:set_title("git")

    tab1:activate()
    wezterm.log_info("spawning window for " .. id .. ".")
  end

  window:perform_action(
    act.SwitchToWorkspace({
      name = clean_workspace_name(label),
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
      action = wezterm.action_callback(function(window, pane)
        window:perform_action(
          act.InputSelector({
            title = "Select workspace",
            description = "(" .. git_project_home_dir .. ") Select workspace: Enter = accept, Esc = cancel, / = filter",
            choices = get_workspaces(),
            action = action,
          }), pane)
      end)
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
