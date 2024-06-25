return {
	"vuki656/package-info.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local package_info = require("package-info")
		package_info.setup({
			hide_up_to_date = true,
			hide_unstable_versions = false,
			package_manager = "npm",
		})

		local pinfo_group = vim.api.nvim_create_augroup("wjohnsto_pinfo", {})

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			group = pinfo_group,
			pattern = "*",
			callback = function()
				local filepath = vim.fn.expand("%")
				if not string.find(filepath, "package.json") then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, remap = false, silent = true, desc = "Update pkg version" }

				print("test")
				-- Update dependency on the line
				vim.keymap.set({ "n" }, "<leader>u", package_info.update, opts)
			end,
		})
	end,
}
