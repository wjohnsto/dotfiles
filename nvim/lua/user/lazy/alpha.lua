-- α alpha-nvim
-- alpha is a fast and fully programmable greeter for neovim.
-- https://github.com/goolord/alpha-nvim/

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
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

    local group_width = 70
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

            local function get_val_and_hl(v)
              local val = v.val
              local hl = v.opts.hl
              local short_val = val:gsub("%" .. cwd, last_partial)
              local _, first_space = short_val:find(" ")
              local fn = short_val:sub(first_space + 2, #short_val)
              local short_fn = shorten_path(fn, "/", group_width - first_space - 5)
              local ico_txt = short_val:sub(1, first_space)
              local fn_start = short_fn:match(".*[/\\]")
              v.val = ico_txt .. short_fn

              if fn_start ~= nil then
                table.remove(hl, #hl)
                table.insert(hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
              end

              v.opts.hl = hl
              return ico_txt .. short_fn, hl
            end

            for _, v in pairs(mru.val) do
              v.opts.position = "center"
              v.opts.width = group_width
              v.opts.cursor = 3
              v.val, v.opts.hl = get_val_and_hl(v)
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

      btn.opts.width = group_width
      btn.opts.align_shortcut = "left"
      btn.opts.shortcut = "[" .. sc .. "] "
      btn.opts.hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } }

      return btn
    end

    -- Set menu
    dashboard.section.buttons.val = {
      custom_button("e", "   New file", "<cmd>ene <BAR> startinsert <CR>"),
      custom_button("f", "   Find file", "<cmd>Telescope find_files<CR>"),
      custom_button("g", "󰱼   Find word", "<cmd>Telescope live_grep<CR>"),

      custom_button("r", "   Find recent files", function()
        -- Finds the git root and uses it as the cwd if it exists
        local telescope = require("telescope")
        local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
        local opts = { workspace = "CWD", prompt_title = "Find recent files" }

        if vim.v.shell_error == 0 then
          opts.cwd = root
        end

        telescope.extensions.frecency.frecency(opts)
      end),
      --custom_button("r", "   All recent files", "<cmd>Telescope oldfiles only_cwd=true<CR>"),
      custom_button("t", "   Todo", "<cmd>TodoTelescope<CR>"),
      custom_button("m", "󱌣   Mason", "<cmd>Mason<CR>"),
      custom_button("l", "󰒲   Lazy", "<cmd>Lazy<CR>"),
      custom_button("u", "󰂖   Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
      custom_button("q", "   Quit NVIM", "<cmd>qa<CR>"),
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
