return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "marilari88/neotest-vitest",
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
        require("neotest-vitest")({
          filter_dir = function(name)
            return name ~= "node_modules"
          end,
        }),
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

    vim.keymap.set("n", "<leader>tt", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run File" })
    vim.keymap.set("n", "<leader>tT", function()
      neotest.run.run(vim.uv.cwd())
    end, { desc = "Run All Test Files" })
    vim.keymap.set("n", "<leader>tr", function()
      neotest.run.run()
    end, { desc = "Run Nearest" })
    vim.keymap.set("n", "<leader>tl", function()
      neotest.run.run_last()
    end, { desc = "Run Last" })
    vim.keymap.set("n", "<leader>ts", function()
      neotest.summary.toggle()
    end, { desc = "Toggle Summary" })
    vim.keymap.set("n", "<leader>to", function()
      neotest.output.open({ enter = true, auto_close = true })
    end, { desc = "Show Output" })
    vim.keymap.set("n", "<leader>tO", function()
      neotest.output_panel.toggle()
    end, { desc = "Toggle Output Panel" })
    vim.keymap.set("n", "<leader>tS", function()
      neotest.run.stop()
    end, { desc = "Stop" })
    vim.keymap.set("n", "<leader>tw", function()
      neotest.watch.toggle(vim.fn.expand("%"))
    end, { desc = "Toggle Watch" })
  end,
}
