return {
  -- A blazing fast and easy to configure Neovim statusline written in Lua.
  -- https://github.com/nvim-lualine/lualine.nvim
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
      },
    })
  end,
}
