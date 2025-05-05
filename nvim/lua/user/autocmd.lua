local augroup = vim.api.nvim_create_augroup
local user_group = augroup("user", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

-- Highlight yank area
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

-- Open all quickfix lists in Snacks picker
autocmd("BufRead", {
  group = user_group,
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd([[cclose]])
        ---@module 'snacks'
        Snacks.picker.qflist()
      end)
    end
  end,
})

-- Trim whitespace
autocmd({ "BufWritePre" }, {
  group = user_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Bind all of the lsp keys after attaching the LSP
autocmd("LspAttach", {
  group = user_group,
  callback = function(e)
    local opts = function(desc)
      return {
        buffer = e.buf,
        noremap = true,
        silent = true,
        desc = desc,
      }
    end
    -- Signature info
    -- Not needed in Neovim >=0.10.0
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover info"))

    -- Signature help
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts("Signature help"))

    -- Add workspace folder
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add ws folder"))

    -- Remove workspace folder
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove ws folder"))

    -- List workspace folders
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("List ws folders"))

    -- Rename symbol
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))

    -- See code actions menu
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code actions"))

    -- Open diagnostics flow
    -- Mapped to <C-W>d or <C-W><C-D> in Neovim >=0.10.0 ... good enough
    -- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts("Open diagnostic float"))

    -- Goto next diagnostic issue
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("[diag] Goto next"))

    -- Go to previous diagnostic issue
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("[diag] Goto prev"))

    -- Set loclist
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts("Set loclist"))

    -- Format file
    vim.keymap.set("n", "<leader>i", function()
      vim.lsp.buf.format({ async = true })
    end, opts("Format file"))
  end,
})
