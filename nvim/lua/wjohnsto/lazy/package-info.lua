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

    -- Update dependency on the line
    vim.keymap.set({ "n" }, "<leader>nu", package_info.update, { silent = true, noremap = true })
  end,
}
