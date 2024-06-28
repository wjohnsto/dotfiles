return {
	-- mason-null-ls bridges mason.nvim with the null-ls plugin
	-- - making it easier to use both plugins together.
	-- https://github.com/jay-babu/mason-null-ls.nvim
	"jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- See lsp.lua
		"williamboman/mason.nvim",
		-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
		-- https://github.com/nvimtools/none-ls.nvim
		"nvimtools/none-ls.nvim",
		-- Extra sources for nvimtools/none-ls.nvim.
		-- https://github.com/nvimtools/none-ls-extras.nvim
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		require("mason").setup()

		-- local null_ls = require("null-ls")
		-- null_ls.setup({
		-- 	sources = {
		-- 		null_ls.builtins.formatting.prettierd,
		-- 		null_ls.builtins.formatting.sqlfmt,
		-- 		null_ls.builtins.formatting.stylua,
		-- 	},
		-- })

		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"prettierd",
				"sqlfmt",
			},
			automatic_installation = true,
		})
	end,
}
