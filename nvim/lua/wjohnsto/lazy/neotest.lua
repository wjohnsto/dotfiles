return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      discovery = {
        enabled = false,
      },
      adapters = {
        require("neotest-plenary"),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
          jest_test_discovery = true,
        }),
      },
    })

    vim.keymap.set("n", "<leader>tc", function()
      neotest.run.run()
    end)
  end,
}
