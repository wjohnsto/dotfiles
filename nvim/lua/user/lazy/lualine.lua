return {
  -- A blazing fast and easy to configure Neovim statusline written in Lua.
  -- https://github.com/nvim-lualine/lualine.nvim
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "stevearc/aerial.nvim" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
      },
      sections = {
        lualine_x = {
          "aerial", "filetype", "encoding", "fileformat",
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          }
        },
      },
    })
  end,
}
