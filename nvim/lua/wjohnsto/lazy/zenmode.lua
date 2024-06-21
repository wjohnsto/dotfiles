return {
  "folke/zen-mode.nvim",
  config = function()
    local zen_mode = require("zen-mode")
    vim.keymap.set("n", "<leader>zz", function()
      zen_mode.setup({
        window = {
          width = 120,
          options = {},
        },
      })
      zen_mode.toggle()
      vim.wo.wrap = true
      vim.wo.number = true
      vim.wo.rnu = true
      SetColorScheme()
    end)
  end,
}
