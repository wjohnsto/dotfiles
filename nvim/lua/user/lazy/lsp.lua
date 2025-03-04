return {
  -- Configs for the Nvim LSP client (:help lsp).
  -- https://github.com/neovim/nvim-lspconfig
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    -- mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
    -- https://github.com/williamboman/mason-lspconfig.nvim
    "williamboman/mason-lspconfig.nvim",
    -- See completions.lua
    "hrsh7th/cmp-nvim-lsp",
    -- Extensible UI for Neovim notifications and LSP progress messages.
    -- https://github.com/j-hui/fidget.nvim
    "j-hui/fidget.nvim",
  },
  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup()

    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "cssmodules_ls",
        "css_variables",
        "unocss",
        "dockerls",
        "docker_compose_language_service",
        "gopls",
        "html",
        "htmx",
        "jsonls",
        "ts_ls",
        "lua_ls",
        "remark_ls",
        "mdx_analyzer",
        "prismals",
        "sqlls",
        "tailwindcss",
        "templ",
        "vimls",
        "yamlls",
      },
      automatic_installation = true,
      handlers = {
        function(server_name) -- default handler
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["cssls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.cssls.setup({
            capabilities = capabilities,
            settings = {
              css = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore"
                }
              },
              scss = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore"
                }
              },
              less = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore"
                }
              },
            },
          })
        end,
        -- Gets rid of those pesky errors all over the place for these globals in nvim config
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
        end,
      },
    })

    require('lspconfig.ui.windows').default_options.border = 'rounded'
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = _border,
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}
