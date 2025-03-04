-- Call this from anywhere to set the color scheme
-- @param color string the color scheme
function ColorScheme(color)
  color = color or "carbonfox"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  return color
end

return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = false,     -- Disable setting background
          terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,    -- Non focused panes set to alternative background
          module_default = true,   -- Default enable value for modules
          colorblind = {
            enable = true,         -- Enable colorblind support
            simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
            -- severity = {
            --   protan = 0.3,        -- Severity [0,1] for protan (red)
            --   deutan = 0.6,        -- Severity [0,1] for deutan (green)
            --   tritan = 0,          -- Severity [0,1] for tritan (blue)
            -- },
          },
          styles = {           -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "bold",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = true,
            visual = true,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      ColorScheme("carbonfox")
    end
  }
}
