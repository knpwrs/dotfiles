local theme = require('tokyonight')
local g = vim.g
local cmd = vim.cmd

theme.setup({
  style = 'night',
  lualine_bold = true,
  on_colors = function(colors)
    colors.bg = '#000000'
    colors.bg_dark = '#000000'
    colors.bg_sidebar = '#000000'
  end
})

cmd[[colorscheme tokyonight-night]]

-- Highlight yanked regions
cmd([[
  augroup HighlightYank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
]])
