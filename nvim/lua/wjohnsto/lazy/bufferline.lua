return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.opt.termguicolors = true
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "neo-tree",
            text_align = "left",
            highlight = "Directory",
            separator = true,
          },
        },
        color_icons = true,
        separator_style = "slant",
        style_preset = "minimal",
      },
    })

    bufferline.sort_by("directory")
    SetColorScheme()
  end,
}
