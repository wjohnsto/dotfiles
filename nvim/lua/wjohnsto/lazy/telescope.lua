return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.6",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"vuki656/package-info.nvim",
	},

	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--hidden",
					"--line-number",
					"--column",
					"--smart-case",
					"--glob",
					"!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock,**/pnpm-lock.yaml}",
					"-u", -- thats the new thing
				},
				file_ignore_patterns = {
					"node_modules",
					"build",
					"dist",
					"yarn.lock",
					".git",
					".fonts",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				grep_string = {
					-- additional_args = { "--hidden" },
				},
				live_grep = {
					-- additional_args = { "--hidden" },
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				package_info = {
					-- Optional theme (the extension doesn't set a default theme)
					theme = "ivy",
				},
			},
		})

		telescope.load_extension("package_info")
		telescope.load_extension("ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
		vim.keymap.set("n", "<C-g>", builtin.grep_string, {})
		vim.keymap.set("n", "<C-b>", builtin.buffers, {})
		vim.keymap.set("n", "<C-h>", builtin.help_tags, {})
	end,
}
