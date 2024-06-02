return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim" -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information-
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = false,
            sort_function = nil,
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_hidden = false,
                    always_show = {".gitignore"},
                    never_show = {".DS_Store", "thumbs.db"}
                }
            }
        })

        vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>")
        vim.cmd([[nnoremap \ :Neotree filesystem reveal left<CR>]])
    end
}
