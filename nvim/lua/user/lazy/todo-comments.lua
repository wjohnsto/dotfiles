return {
  -- todo-comments is a lua plugin for Neovim >= 0.8.0
  -- to highlight and search for todo comments like TODO, HACK, BUG in your code base.
  -- https://github.com/folke/todo-comments.nvim
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({})

    -- Open todo list in telescope
    vim.keymap.set("n", "<leader>td", ":TodoQuickFix<CR>", { desc = "Todo list" })
  end,
}
