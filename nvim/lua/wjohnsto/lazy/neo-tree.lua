return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim", -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information-
                    {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        config = function()
            require('window-picker').setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = {'neo-tree', "neo-tree-popup", "notify"},
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = {'terminal', "quickfix"}
                    }
                }
            })
        end
    }},
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
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false
                }
            }
        })

        vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>")
        vim.cmd([[nnoremap \ :Neotree filesystem reveal left<CR>]])
    end
}
