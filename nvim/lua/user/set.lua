-- Line numbers
vim.opt.nu = true

-- Show line numbers relative to cursor
vim.opt.relativenumber = true

-- Default to 2 spaces for a tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search is case insensitive
vim.opt.ignorecase = false
-- case matters for searches with capital letters
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"

-- redraw for macros
vim.opt.lazyredraw = true

-- Automatic in Neovim >=0.10.0
-- vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Add dash to recognized filename characters
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.splitkeep = "screen"
vim.opt.laststatus = 3

