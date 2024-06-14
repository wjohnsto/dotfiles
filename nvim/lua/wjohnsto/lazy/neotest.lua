return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"marilari88/neotest-vitest",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-jest",
	},
	config = function()
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-plenary"),
				require("neotest-vitest")({
					filter_dir = function(name)
						return name ~= "node_modules"
					end,
				}),
				require("neotest-jest")({
					jestCommand = "npm test --",
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
