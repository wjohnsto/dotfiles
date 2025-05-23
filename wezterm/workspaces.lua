local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local exports = {}
local git_project_home_dir = wezterm.home_dir .. "/src"
local action_new_workspace = act.PromptInputLine({
    description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace" },
    }),
    action = wezterm.action_callback(function(workspace, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
            workspace:perform_action(
                act.SwitchToWorkspace({
                    name = line,
                    spawn = {
                        cwd = wezterm.home_dir
                    }
                }),
                pane
            )
        end
    end),
})

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
        if not string.find(cname, "/") then
            table.insert(choices, { label = "* " .. cname, id = cname })
        else
            table.insert(choices, { label = "* " .. cname, id = git_project_home_dir .. cname })
        end
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
                    break
                end

                add_path(name, depth + 1, ignores)
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

    table.insert(choices, {
        label = "Create a new workspace",
        id = "n",
    })

    return choices
end

local action_switch_workspace = wezterm.action_callback(function(window, pane, id, label)
    if not id and not label then
        return
    end

    wezterm.log_info("attempting to switch to workspace id: " .. id .. ", label: " .. label .. ".")

    if id == "n" then
        window:perform_action(action_new_workspace, pane)

        return
    end

    if not string.find(id, git_project_home_dir) then
        window:perform_action(
            act.SwitchToWorkspace({
                name = clean_workspace_name(label),
            }),
            pane
        )

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

    local venv_exists = false
    for _, name in ipairs(wezterm.read_dir(id)) do
        if name == id .. "/.venv" then
            venv_exists = true
            break
        end
    end

    if not workspace_exists then
        local spawn_cmd = { workspace = clean_workspace_name(label), cwd = id }

        local tab1, pane1, win = mux.spawn_window(spawn_cmd)

        tab1:set_title("short term")

        local tab2, pane2 = win:spawn_tab({ cwd = id })
        tab2:set_title("long term")

        -- local tab3, pane3 = win:spawn_tab({ cwd = id })
        -- tab3:set_title("long term")

        local text1 = "zed .\n"
        local text2 = ""
        local text3 = ""

        if venv_exists then
            text1 = "source .venv/bin/activate && zed .\n"
            text2 = "source .venv/bin/activate\n"
            -- text3 = "source .venv/bin/activate\n"
        end

        if string.len(text1) > 0 then
            pane1:send_text(text1)
        end

        if string.len(text2) > 0 then
            pane2:send_text(text2)
        end

        -- if string.len(text3) > 0 then
        --   pane3:send_text(text3)
        -- end

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

local action_select_workspace = wezterm.action_callback(function(window, pane)
    window:perform_action(
        act.InputSelector({
            title = "Select workspace",
            description = "(" .. git_project_home_dir .. ") Select workspace: Enter = accept, Esc = cancel, / = filter",
            choices = get_workspaces(),
            action = action_switch_workspace,
        }), pane)
end)


function exports:apply(config)
    local keys = {
        {
            key = "w",
            mods = "LEADER",
            -- Asks to select a workspace from a list of pre-defined and already existing workspaces.
            -- First, if the selected workspace does not already exist, spawn a window in it with
            -- a specifed cwd. Then, switch to the workspace.
            action = action_select_workspace
        },
        {
            key = "f",
            mods = "LEADER",
            -- Asks to select a workspace from a list of pre-defined and already existing workspaces.
            -- First, if the selected workspace does not already exist, spawn a window in it with
            -- a specifed cwd. Then, switch to the workspace.
            action = action_select_workspace
        },

    }

    for _, key in ipairs(keys) do
        table.insert(config.keys, key)
    end
end

return exports
