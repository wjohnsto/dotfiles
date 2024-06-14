return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    require("mason").setup()

    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.sqlfmt,
        null_ls.builtins.formatting.stylua,
        -- require("none-ls.diagnostics.eslint_d"),
      },
    })

    require("mason-null-ls").setup({
      ensure_installed = {
        "stylua",
        "prettierd", --[["eslint_d",]]
        "sqlfmt",
      },
      automatic_installation = true,
    })
  end,
}
