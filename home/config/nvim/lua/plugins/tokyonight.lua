local g = vim.g
local cmd = vim.cmd

g.tokyonight_style = 'night'
g.tokyonight_colors = { bg = '#000000', bg_dark = '#000000', bg_sidebar = '#000000' }

cmd[[colorscheme tokyonight]]

-- Highlight yanked regions
cmd([[
  augroup HighlightYank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
]])
