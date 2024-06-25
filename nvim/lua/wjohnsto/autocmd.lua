local augroup = vim.api.nvim_create_augroup
local wjohnsto_group = augroup("wjohnsto", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

autocmd("BufRead", {
  group = wjohnsto_group,
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd([[cclose]])
        vim.cmd([[Trouble qflist open]])
      end)
    end
  end,
})

autocmd({ "BufWritePre" }, {
  group = wjohnsto_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
  group = wjohnsto_group,
  callback = function(e)
    local opts = function(desc)
      return {
        buffer = e.buf,
        noremap = true,
        silent = true,
        desc = desc,
      }
    end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover info"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts("Signature help"))
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add ws folder"))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove ws folder"))
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("List ws folders"))
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("See typedef"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Get references"))
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts("Open diagnostic float"))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("[diag] Goto next"))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("[diag] Goto prev"))
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts("Set loclist"))

    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts("Format file"))
  end,
})
