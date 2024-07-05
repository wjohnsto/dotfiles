return {
  -- telescope.nvim is a highly extendable fuzzy finder over lists.
  -- Built on the latest awesome features from neovim core.
  -- Telescope is centered around modularity, allowing for easy customization.
  -- https://github.com/nvim-telescope/telescope.nvim
  "nvim-telescope/telescope.nvim",

  tag = "0.1.8",

  dependencies = {
    "nvim-lua/plenary.nvim",
    -- It sets vim.ui.select to telescope.
    -- That means for example that neovim core stuff can fill the telescope picker.
    -- Example would be lua vim.lsp.buf.code_action().
    -- https://github.com/nvim-telescope/telescope-ui-select.nvim
    "nvim-telescope/telescope-ui-select.nvim",
    -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history.
    -- https://github.com/nvim-telescope/telescope-frecency.nvim
    "nvim-telescope/telescope-frecency.nvim",
    -- See package-info.lua
    "vuki656/package-info.nvim",
    -- See trouble.lua
    "folke/trouble.nvim",
    -- Visualize your undo tree and fuzzy-search changes in it.
    -- For those days where committing early and often doesn't work out.
    -- https://github.com/debugloop/telescope-undo.nvim
    "debugloop/telescope-undo.nvim",
    -- See aerial.nvim
    "stevearc/aerial.nvim",
    -- See flash.nvim
    "folke/flash.nvim",
  },

  config = function()
    local telescope = require("telescope")
    local function flash(prompt_bufnr)
      require("flash").jump({
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
            end,
          },
        },
        action = function(match)
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          picker:set_selection(match.pos[1] - 1)
        end,
      })
    end
    telescope.setup({
      defaults = {
        get_selection_window = function()
          require("edgy").goto_main()
          return 0
        end,
        mappings = {
          -- If you look at autocmd.lua we automatically open Trouble for the qflist
          -- So this is not needed
          -- i = { ["<c-q>"] = open_with_trouble },
          -- n = { ["<c-q>"] = open_with_trouble },
          n = { s = flash },
          i = { ["<c-s>"] = flash },
        },
        -- Use this to allow grepping (with ripgrep) over hidden files
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--hidden",
          "--line-number",
          "--column",
          "--smart-case",
          "--glob",
          "!{**/.git/*,**/.next/*,**/node_modules/*,**/package-lock.json,**/yarn.lock,**/pnpm-lock.yaml}",
          "-u", -- thats the new thing
        },
        file_ignore_patterns = {
          "node_modules",
          "build",
          "dist",
          "yarn.lock",
          ".git",
          ".next",
          ".fonts",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        package_info = {
          -- Optional theme (the extension doesn't set a default theme)
          theme = "dropdown",
        },
        frecency = {
          db_safe_mode = false,
          auto_validate = false,
          matcher = "fuzzy",
        },
        aerial = {
          -- Display symbols as <root>.<parent>.<symbol>
          show_nesting = {
            ["_"] = false, -- This key will be the default
            json = true,   -- You can set the option for specific filetypes
            yaml = true,
          },
        },
      },
    })

    telescope.load_extension("package_info")
    telescope.load_extension("ui-select")
    telescope.load_extension("undo")
    telescope.load_extension("frecency")
    telescope.load_extension("aerial")

    -- Open undo list
    vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<CR>", { desc = "Telescope undo" })

    -- Open file list by most frequently used
    vim.keymap.set("n", "<C-S-P>", function()
      -- Finds the git root and uses it as the cwd if it exists
      local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
      local opts = { workspace = "CWD", prompt_title = "Find MRU Files" }

      if vim.v.shell_error == 0 then
        opts.cwd = root
      end

      telescope.extensions.frecency.frecency(opts)
    end, { desc = "Find MRU Files" })

    local builtin = require("telescope.builtin")
    -- Open find files list
    vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })

    -- Open jump list
    vim.keymap.set("n", "<C-m>", builtin.jumplist, { desc = "Jump list" })

    -- Open live grep list
    vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Live grep" })

    -- Open find word (grep) list
    vim.keymap.set("n", "<C-g>", builtin.grep_string, { desc = "Find word" })

    -- Open buffer list
    vim.keymap.set("n", "<C-b>", builtin.buffers, { desc = "Find buffer" })

    -- Open help
    vim.keymap.set("n", "<C-h>", builtin.help_tags, { desc = "Help" })

    -- Open find symbols list
    vim.keymap.set("n", "<leader>os", "<cmd>Telescope aerial<CR>", { desc = "Find symbol" })
  end,
}
