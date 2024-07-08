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
              v.opts.position = "center"
              v.opts.width = 50
              v.opts.cursor = 3
              -- v.opts = {
              -- 	position = "center",
              -- 	shortcut = v.opts.shortcut,
              -- 	cursor = 3,
              -- 	width = 50,
              -- 	align_shortcut = "left",
              -- 	hl_shortcut = "Keyword",
              -- 	keymap = v.opts.keymap,
              -- }
              v.val = v.val:gsub("%" .. cwd, last_partial)
            end
            mru.opts = { shrink_margin = false }
            return { mru }
          end,
          opts = { shrink_margin = false },
        },
      },
    }

    local function custom_button(sc, txt, keybind)
      local btn = dashboard.button(sc, txt, keybind)
      local sc = btn.opts.shortcut

      btn.opts.align_shortcut = "left"
      btn.opts.shortcut = "[" .. sc .. "] "
      btn.opts.hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } }

      return btn
    end

    -- Set menu
    dashboard.section.buttons.val = {
      custom_button("e", "   New file", ":ene <BAR> startinsert <CR>"),
      custom_button("f", "   Find file", ":Telescope find_files<CR>"),
      custom_button("g", "󰱼   Find word", ":Telescope live_grep<CR>"),
      custom_button("r", "   All recent files", ":Telescope oldfiles only_cwd=true<CR>"),
      custom_button("m", "󱌣   Mason", ":Mason<CR>"),
      custom_button("l", "󰒲   Lazy", ":Lazy<CR>"),
      custom_button("u", "󰂖   Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
      custom_button("q", "   Quit NVIM", ":qa<CR>"),
    }
    dashboard.section.buttons.opts.spacing = 0

    local config = {
      layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        mru_cwd,
        { type = "padding", val = 1 },
        {
          type = "text",
          val = "Commands",
          opts = { hl = "SpecialComment", shrink_margin = false, position = "center", width = 50 },
        },
        { type = "padding", val = 1 },
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
