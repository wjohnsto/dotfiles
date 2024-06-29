return {
  -- Fugitive is the premier Vim plugin for Git.
  -- Or maybe it's the premier Git plugin for Vim?
  -- Either way, it's "so awesome, it should be illegal".
  -- That's why it's called Fugitive.
  -- https://github.com/tpope/vim-fugitive
  "tpope/vim-fugitive",
  config = function()
    -- Enter fugitive
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

    local fugitive_group = vim.api.nvim_create_augroup("wjohnsto_fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd

    -- Only bind the commands when you enter the fugitive buffer
    autocmd("BufWinEnter", {
      group = fugitive_group,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()

        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git("push")
        end, { buffer = bufnr, remap = false, desc = "git push" })

        vim.keymap.set("n", "<leader>P", ":Git pull<CR>", { buffer = bufnr, remap = false, desc = "git pull" })

        vim.keymap.set("n", "<leader>u", ":Git push -u origin ", {
          buffer = bufnr,
          remap = false,
          desc = "git push -u"
        })
      end,
    })

    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
  end,
}
