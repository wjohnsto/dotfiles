return {
	-- Distraction-free coding for Neovim >= 0.5
	-- https://github.com/folke/zen-mode.nvim
	"folke/zen-mode.nvim",
	config = function()
		local zen_mode = require("zen-mode")
		vim.keymap.set("n", "<leader>zz", function()
			zen_mode.setup({
				window = {
					width = 80,
					options = {},
				},
				plugins = {
					wezterm = {
						enabled = false,
						-- can be either an absolute font size or the number of incremental steps
						-- (10% increase per step)
						font = "+4",
					},
				},
			})
			zen_mode.toggle()
			vim.wo.wrap = true
			vim.wo.number = true
			vim.wo.rnu = true
			ColorScheme()
		end, { desc = "Zen mode toggle" })
	end,
}
