return {
  {
    -- nvim-cmp provides manually triggered completion that can replace omnifunc.
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    -- Adds snippets, lets you customize with lua
    -- https://github.com/L3MON4D3/LuaSnip
    "L3MON4D3/LuaSnip",
    dependencies = {
      -- LuaSnip completion source for nvim-cmp
      -- https://github.com/saadparwaiz1/cmp_luasnip
      "saadparwaiz1/cmp_luasnip",
      -- Snippets collection for a set of different programming languages.
      -- https://github.com/rafamadriz/friendly-snippets
      "rafamadriz/friendly-snippets",
    },
  },
  {
    -- A completion engine plugin for neovim written in Lua.
    -- Completion sources are installed from external repositories and "sourced".
    -- https://github.com/hrsh7th/nvim-cmp
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- nvim-cmp source for buffer words.
      -- https://github.com/hrsh7th/cmp-buffer
      "hrsh7th/cmp-buffer",
      -- nvim-cmp source for filesystem paths.
      -- https://github.com/hrsh7th/cmp-path
      "hrsh7th/cmp-path",
      -- nvim-cmp source for vim's cmdline.
      -- https://github.com/hrsh7th/cmp-cmdline
      "hrsh7th/cmp-cmdline",
      -- See highlight-colors.lua
      "brenoprata10/nvim-highlight-colors",
      -- copilot
      -- https://github.com/zbirenbaum/copilot.lua
      "zbirenbaum/copilot.lua",
      -- copilot-cmp
      -- https://github.com/zbirenbaum/copilot-cmp
      "zbirenbaum/copilot-cmp",

    },
    config = function()
      local cmp = require("cmp")
      -- Load some of the vscode snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      require("copilot").setup({
        -- copilot_model = "gpt-4o-copilot",
        copilot_model = "gemini-2.0-flash",
      })
      require("copilot_cmp").setup()

      cmp.setup({
        completion = {
          autocomplete = false,
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          -- Copilot Source
          { name = "copilot", group_index = 2 },
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = require("nvim-highlight-colors").format
        },
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = "buffer" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
