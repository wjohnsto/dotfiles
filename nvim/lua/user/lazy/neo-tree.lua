return {
	-- Neo-tree is a Neovim plugin to browse the file system and other tree like structures
	-- in whatever style suits you, including sidebars, floating windows, netrw split style,
	-- or all of them at once!
	-- https://github.com/nvim-neo-tree/neo-tree.nvim
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- not strictly required, but recommended
		"nvim-tree/nvim-web-devicons",
		-- Optional image support in preview window: See `# Preview Mode` for more information
		-- https://github.com/3rd/image.nvim
		"3rd/image.nvim",
		-- UI Component Library for Neovim.
		-- https://github.com/MunifTanjim/nui.nvim
		"MunifTanjim/nui.nvim",
		{
			-- This plugins prompts the user to pick a window and returns the window id of the picked window.
			-- https://github.com/s1n7ax/nvim-window-picker
			"s1n7ax/nvim-window-picker",
			version = "2.*",
			config = function()
				require("window-picker").setup({
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { "neo-tree", "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { "terminal", "quickfix" },
						},
					},
				})
			end,
		},
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			sort_case_insensitive = false,
			sort_function = nil,
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
					always_show = { ".gitignore", ".env" },
					-- uses glob style patterns
					always_show_by_pattern = {
						".env*",
					},
					never_show = { ".DS_Store", "thumbs.db", ".git", "node_modules" },
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
			},
		})

		vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>", { desc = "Toggle neo-tree" })
		vim.cmd([[nnoremap \ :Neotree filesystem reveal left<CR>]])
	end,
}
