return {
  {
    "folke/trouble.nvim",
    config = function()
      local trouble = require("trouble")
      trouble.setup({
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

      vim.keymap.set("n", "<leader>xx", function()
        trouble.toggle("diagnostics")
      end)

      vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.bu=0<CR>")
      vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>")
      vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>")
      vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>")
      vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>")


      vim.keymap.set("n", "[t", function()
        trouble.next({ skip_groups = true, jump = true })
      end)

      vim.keymap.set("n", "]t", function()
        trouble.previous({ skip_groups = true, jump = true })
      end)
    end,
  },
}
