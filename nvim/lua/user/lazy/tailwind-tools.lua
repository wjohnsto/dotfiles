return {
  -- Unofficial Tailwind CSS integration and tooling for Neovim using the built-in LSP client and treesitter, inspired
  -- by the official Visual Studio Code extension.
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("tailwind-tools").setup({
      custom_filetypes = { "pug" },
    })
  end
}
