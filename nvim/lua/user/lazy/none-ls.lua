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

		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"prettierd"
			},
			automatic_installation = true,
		})
	end,
}
