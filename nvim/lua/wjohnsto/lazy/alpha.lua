return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
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

		local function mru_title()
			return "Recently used files in: " .. vim.fn.getcwd()
		end

		local mru_cwd = {
			type = "group",
			val = {
				{ type = "padding", val = 1 },
				{ type = "text", val = mru_title, opts = { hl = "SpecialComment", shrink_margin = false, position = "center", width = 50 } },
				{ type = "padding", val = 1 },
				{
					type = "group",
					val = function()
            			local mru = startify.mru(0, vim.fn.getcwd())

						for _, v in pairs(mru.val) do
							v.opts = {
								position = "center",
								shortcut = v.opts.shortcut,
								-- shortcut = sc,
								cursor = 3,
								width = 50,
								align_shortcut = "left",
								hl_shortcut = "Keyword",
							}
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
			--dashboard.button("s", "󰈚   Restore Session", ":SessionRestore<cr>"),
			dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
			dashboard.button("g", "󰱼   Find word", ":Telescope live_grep<CR>"),
			dashboard.button("r", "   All recent files", ":Telescope oldfiles<CR>"),
			--dashboard.button("c", "   Config", ":e $MYVIMRC <CR>"),
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
