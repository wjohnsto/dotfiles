-- α alpha-nvim
-- alpha is a fast and fully programmable greeter for neovim.
-- https://github.com/goolord/alpha-nvim/

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")

		-- Primary theme
		local dashboard = require("alpha.themes.dashboard")

		-- Used to get most recently used list
		local startify = require("alpha.themes.startify")

		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
		}

		local function get_last_partial(path)
			local t = {}
			for str in string.gmatch(path, "([^/]+)") do
				table.insert(t, str)
			end

			return t[#t]
		end

		local function mru_title()
			return "Recently used files in: " .. get_last_partial(vim.fn.getcwd())
		end

		local function has_value(val, tab)
			if tab == nil or val == nil then
				return false
			end

			for _, value in ipairs(tab) do
				local _, j = string.find(val, value)

				if type(j) == "number" then
					return true
				end
			end

			return false
		end

		local mru_cwd = {
			type = "group",
			val = {
				{ type = "padding", val = 1 },
				{
					type = "text",
					val = mru_title,
					opts = { hl = "SpecialComment", shrink_margin = false, position = "center", width = 50 },
				},
				{ type = "padding", val = 1 },
				{
					type = "group",
					val = function()
						local cwd = vim.fn.getcwd()
						local mru = startify.mru(0, cwd .. "/", 10, {
							ignore = function(v)
								return has_value(v, { "node_modules" })
							end,
						})
						local last_partial = get_last_partial(cwd)

						for _, v in pairs(mru.val) do
							v.opts = {
								position = "center",
								shortcut = v.opts.shortcut,
								cursor = 3,
								width = 50,
								align_shortcut = "left",
								hl_shortcut = "Keyword",
								keymap = v.opts.keymap,
							}
							v.val = v.val:gsub("%" .. cwd, last_partial)
						end
						mru.opts = { shrink_margin = false }
						return { mru }
					end,
					opts = { shrink_margin = false },
				},
			},
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
			dashboard.button("g", "󰱼   Find word", ":Telescope live_grep<CR>"),
			dashboard.button("r", "   All recent files", ":Telescope oldfiles<CR>"),
			dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
			dashboard.button("l", "󰒲   Lazy", ":Lazy<CR>"),
			dashboard.button("u", "󰂖   Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
			dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
		}

		local config = {
			layout = {
				{ type = "padding", val = 2 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				mru_cwd,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				dashboard.section.footer,
			},
			opts = {
				margin = 5,
			},
		}

		alpha.setup(config)
	end,
}