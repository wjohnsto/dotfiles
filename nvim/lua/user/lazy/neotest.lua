return {
	-- A framework for interacting with tests within NeoVim.
	-- https://github.com/nvim-neotest/neotest
	"nvim-neotest/neotest",
	dependencies = {
		-- A library for asynchronous IO in Neovim, inspired by the asyncio library in Python.
		-- The library focuses on providing both common asynchronous primitives and asynchronous APIs for Neovim's core.
		-- https://github.com/nvim-neotest/nvim-nio
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		-- Allows detaching updatetime from the CursorHold event
		-- Recommended by neotest
		-- https://github.com/antoinemadec/FixCursorHold.nvim
		"antoinemadec/FixCursorHold.nvim",
		-- This plugin provides a Vitest adapter for the Neotest framework.
		-- https://github.com/marilari88/neotest-vitest
		"marilari88/neotest-vitest",
		-- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface
		-- for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it
		-- See treesitter.lua
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-plenary",
		-- This plugin provides a jest adapter for the Neotest framework.
		-- Requires at least Neotest version 4.0.0 which in turn requires at least neovim version 0.9.0.
		-- https://github.com/nvim-neotest/neotest-jest
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

		-- Run all tests in a file
		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run File" })

		-- Run all tests in all files
		vim.keymap.set("n", "<leader>tT", function()
			neotest.run.run(vim.uv.cwd())
		end, { desc = "Run All Test Files" })

		-- Run nearest test
		vim.keymap.set("n", "<leader>tr", function()
			neotest.run.run()
		end, { desc = "Run Nearest" })

		-- Run last test
		vim.keymap.set("n", "<leader>tl", function()
			neotest.run.run_last()
		end, { desc = "Run Last" })

		-- Toggle test summary split
		vim.keymap.set("n", "<leader>ts", function()
			neotest.summary.toggle()
		end, { desc = "Toggle Summary" })

		-- Show test output
		vim.keymap.set("n", "<leader>to", function()
			neotest.output.open({ enter = true, auto_close = true })
		end, { desc = "Show Output" })

		-- Toggle test output panel
		vim.keymap.set("n", "<leader>tO", function()
			neotest.output_panel.toggle()
		end, { desc = "Toggle Output Panel" })

    -- Stop test run
		vim.keymap.set("n", "<leader>tS", function()
			neotest.run.stop()
		end, { desc = "Stop" })

    -- Toggle watch mode to rerun tests on change
		vim.keymap.set("n", "<leader>tw", function()
			neotest.watch.toggle(vim.fn.expand("%"))
		end, { desc = "Toggle Watch" })
	end,
}
