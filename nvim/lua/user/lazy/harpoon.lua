return {
  -- Problems:
  -- 1. You're working on a codebase. medium, large, tiny, whatever.
  -- You find yourself frequenting a small set of files and you are tired of using a fuzzy finder,
  -- :bnext & :bprev are getting too repetitive, alternate file doesn't quite cut it, etc etc.
  --
  -- 2. You want to execute some project specific commands, have any number of persistent terminals
  -- that can be easily navigated to, send commands to other tmux windows, or dream up your own
  -- custom action and execute with a single key
  --
  -- Solution:
  -- 1. Specify either by altering a ui or by adding via hot key files
  -- 2. Unlimited lists and items within the lists
  --
  -- https://github.com/ThePrimeagen/harpoon
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    -- add to harpoon list
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Add to harpoon" })

    -- remove from harpoon list
    vim.keymap.set("n", "<leader>r", function()
      harpoon:list():remove()
    end, { desc = "Remove from harpoon" })

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
    end

    -- Open harpoon list using telescope
    vim.keymap.set("n", "<C-e>", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
  end,
}
