return {
  -- avante.nvim is a Neovim plugin designed to emulate the behaviour of the Cursor AI IDE. It provides users with
  -- AI-driven code suggestions and the ability to apply these recommendations directly to their source files with
  -- minimal effort.
  --
  -- https://github.com/yetone/avante.nvim
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  opts = {
    -- add any opts here
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below is optional, make sure to setup it properly if you have lazy=true
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
