local wezterm = require("wezterm")
local act = wezterm.action
local exports = {}

function exports:apply(config)
	local keys = {
		-- Move between panes.
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "s", mods = "LEADER", action = act.PaneSelect },
		-- Create/close panes.
		{
			key = "_",
			mods = "LEADER|SHIFT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{ key = "x", mods = "CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	}

	for _, key in ipairs(keys) do
		table.insert(config.keys, key)
	end
end

return exports
