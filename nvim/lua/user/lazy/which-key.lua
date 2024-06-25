return {
	-- WhichKey is a lua plugin for Neovim 0.5 that displays a popup
	-- with possible key bindings of the command you started typing.
	-- Heavily inspired by the original emacs-which-key and vim-which-key.
	--
	-- Amazing for beginners, but make sure you document your keybindings!
	-- https://github.com/folke/which-key.nvim
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
	},
}
