require("wjohnsto.remap")
require("wjohnsto.set")
require("wjohnsto.lazy_init")
require("wjohnsto.autocmd")

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ'
    }
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
