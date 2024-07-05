return {
  -- A code outline window for skimming and quick navigation
  -- https://github.com/stevearc/aerial.nvim
  "stevearc/aerial.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("aerial").setup({
      layout = {
        default_direction = "left",
        placement = "edge",
        resize_to_content = false,
      },
      close_automatic_events = { "unfocus", "switch_buffer", "unsupported" },
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Jump back" })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Jump forward" })
      end,
    })
    -- You probably also want to set a keymap to toggle aerial
    vim.keymap.set("n", "<leader>ds", "<cmd>AerialToggle!<CR>", { desc = "Toggle document symbols" })
  end
}
