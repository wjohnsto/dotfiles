return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	opts = function()
		local opts = {
			bottom = {
				{
					ft = "trouble",
					title = "Trouble",
					filter = function(_, win)
            if vim.w[win].trouble == nil then
              return false
            end

						return vim.w[win].trouble.mode ~= "symbols"
					end,
				},
				{ ft = "qf", title = "QuickFix" },
				{
					ft = "help",
					size = { height = 20 },
					filter = function(buf)
						return vim.b[buf].buftype == "help"
					end,
				},
				{ title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
			},
			left = {
				-- Neo-tree filesystem always takes half the screen height
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					size = { height = 0.5 },
				},
				{
					ft = "trouble",
          title = "Trouble",
					filter = function(_, win)
            if vim.w[win].trouble == nil then
              return false
            end

						return vim.w[win].trouble.mode == "symbols"
					end,
				},
			},
			keys = {
				-- close window
				["q"] = function(win)
					win:close()
				end,
				-- hide window
				["<c-q>"] = function(win)
					win:hide()
				end,
				-- close sidebar
				["Q"] = function(win)
					win.view.edgebar:close()
				end,
				-- next open window
				["]w"] = function(win)
					win:next({ visible = true, focus = true })
				end,
				-- previous open window
				["[w"] = function(win)
					win:prev({ visible = true, focus = true })
				end,
				-- next loaded window
				["]W"] = function(win)
					win:next({ pinned = false, focus = true })
				end,
				-- prev loaded window
				["[W"] = function(win)
					win:prev({ pinned = false, focus = true })
				end,
				-- increase width
				["<c-Right>"] = function(win)
					win:resize("width", 2)
				end,
				-- decrease width
				["<c-Left>"] = function(win)
					win:resize("width", -2)
				end,
				-- increase height
				["<c-Up>"] = function(win)
					win:resize("height", 2)
				end,
				-- decrease height
				["<c-Down>"] = function(win)
					win:resize("height", -2)
				end,
			},
		}

		return opts
	end,
}
