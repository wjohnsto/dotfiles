return {
	{
		"folke/trouble.nvim",
		config = function()
			local trouble = require("trouble")
			trouble.setup({
				focus = true,
        modes = {
					cascade = {
						mode = "diagnostics", -- inherit from diagnostics mode
						filter = function(items)
							local severity = vim.diagnostic.severity.HINT
							for _, item in ipairs(items) do
								severity = math.min(severity, item.severity)
							end
							return vim.tbl_filter(function(item)
								return item.severity == severity
							end, items)
						end,
					},
				},
			})

			vim.api.nvim_create_autocmd("QuickFixCmdPost", {
				callback = function()
					vim.cmd([[Trouble qflist open]])
				end,
			})

			vim.keymap.set("n", "<leader>qd", "<cmd>Trouble diagnostics toggle focus=true<CR>")
			vim.keymap.set("n", "<leader>qs", "<cmd>Trouble symbols toggle focus=false<CR>")
			vim.keymap.set("n", "<leader>ql", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>")
			vim.keymap.set("n", "<leader>qL", "<cmd>Trouble loclist toggle focus=true<CR>")
			vim.keymap.set("n", "<leader>qf", "<cmd>Trouble qflist toggle focus=true<CR>")

			vim.keymap.set("n", "[t", function()
				trouble.next({ skip_groups = true, jump = true })
			end)

			vim.keymap.set("n", "]t", function()
				trouble.prev({ skip_groups = true, jump = true })
			end)
		end,
	},
}
