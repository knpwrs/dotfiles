local g = vim.g
local cmd = vim.cmd

g.tokyonight_style = 'night'
g.tokyonight_colors = { bg = '#121212', bg_dark = '#101010', bg_sidebar = '#101010' }

cmd[[colorscheme tokyonight]]

-- Highlight yanked regions
cmd([[
  augroup HighlightYank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
]])
