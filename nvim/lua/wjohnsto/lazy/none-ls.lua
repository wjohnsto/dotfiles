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
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.sqlfmt,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.gitsigns,
      },
    })

    require("mason-null-ls").setup({
      ensure_installed = { "stylua", "prettier", "eslint_d", "sqlfmt" },
      automatic_installation = true;
    })
  end,
}
