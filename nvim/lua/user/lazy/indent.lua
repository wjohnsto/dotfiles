return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  main = "ibl",
  config = function()
    require("ibl").setup()
  end
}
