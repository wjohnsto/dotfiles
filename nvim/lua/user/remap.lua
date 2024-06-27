-- Set <leader> key to Space
vim.g.mapleader = " "

local map = vim.keymap.set;

-- Swap current line with next line in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

-- Swap current line with previous line in visual mode
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up " })

-- Take next line and append it to the end of the current line
map("n", "J", "mzJ`z", { desc = "Append next line" })

-- Scroll down and redraw screen to put cursor in the middle
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })

-- Scroll up and redraw screen to put cursor in the middle
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Center the cursor to the next item in a search
map("n", "n", "nzzzv", { desc = "Next search item" })

-- Center the cursor to the previous item in a search
map("n", "N", "Nzzzv", { desc = "Previous search item" })

-- Center the cursor to the search term when using "/"
map("c", "<CR>", function()
	return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
end, { expr = true })

-- Paste from yank into highlighted area, then yank the highlighted area
map("x", "<leader>p", [["_dP]], { desc = "Paste and yank" })

-- Yank to clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })

-- Yank line to clipboard
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete w/o yank" })

-- Prevent accidental fast exit
map("n", "Q", "<nop>")

-- Move to next item in qflist, center cursor
map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next qf item" })

-- Move to the previous item in qflist, center cursor
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev qf item " })

-- Move to the next item in loclist, center cursor
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location" })

-- Move to previous item in loclist, center cursor
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev location" })

-- Take current word and put it into find/replace command, add "/gIc" for automatic confirmation
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Find/replace" })

-- Modify current scipt as executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
	silent = true,
	desc = "chmod +x",
})

-- Source current file
map("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- HJKL LDUR mode
-- map("n", "<Left>", "<nop>")
-- map("n", "<Down>", "<nop>")
-- map("n", "<Up>", "<nop>")
-- map("n", "<Right>", "<nop>")
