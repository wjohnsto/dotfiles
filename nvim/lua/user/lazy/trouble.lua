return {
  {
    -- A pretty list for showing diagnostics, references,
    -- telescope results, quickfix and location lists
    -- to help you solve all the trouble your code is causing.
    -- https://github.com/folke/trouble.nvim
    "folke/trouble.nvim",
    config = function()
      local trouble = require("trouble")
      trouble.setup({
        -- auto_preview = false,
        focus = true,
        preview = {
          type = "main",
          -- when a buffer is not yet loaded, the preview window will be created
          -- in a scratch buffer with only syntax highlighting enabled.
          -- Set to false, if you want the preview to always be a real loaded buffer.
          scratch = false,
        },
        modes = {
          cascade = {
            -- inherit from diagnostics mode
            mode = "diagnostics",
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

      -- Always use Trouble for qflist
      vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        callback = function()
          vim.cmd([[Trouble qflist open]])
        end,
      })

      -- Toggle diagnostics
      vim.keymap.set(
        "n",
        "<leader>qd",
        "<cmd>Trouble diagnostics toggle focus=true<CR>",
        { desc = "Trouble diag" }
      )

      -- Toggle document symbols
      -- vim.keymap.set(
      -- 	"n",
      -- 	"<leader>ds",
      -- 	"<cmd>Trouble symbols toggle focus=false<CR>",
      -- 	{ desc = "Trouble symbols" }
      -- )

      -- Toggle lsp list
      vim.keymap.set(
        "n",
        "<leader>ql",
        "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        { desc = "Trouble lsp" }
      )

      -- Toggle loclist
      vim.keymap.set(
        "n",
        "<leader>qL",
        "<cmd>Trouble loclist toggle focus=true<CR>",
        { desc = "Trouble loclist" }
      )

      -- Toggle qflist
      vim.keymap.set("n", "<leader>qf", "<cmd>Trouble qflist toggle focus=true<CR>", { desc = "Trouble qflist" })

      -- Goto next item in list
      vim.keymap.set("n", "[t", function()
        trouble.next({ jump = true })
      end, { desc = "Trouble next" })

      -- Goto previous item in list
      vim.keymap.set("n", "]t", function()
        trouble.prev({ jump = true })
      end, { desc = "Trouble prev" })
    end,
  },
}
