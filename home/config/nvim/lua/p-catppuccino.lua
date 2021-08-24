local catppuccino = require('catppuccino')
local colors = require('catppuccino.color_schemes.dark_catppuccino')
local cmd = vim.cmd

catppuccino.setup(
  {
    colorscheme = 'dark_catppuccino',
    integrations = {
      bufferline = true,
      gitsigns = true,
      indent_blankline = true,
      lsp_trouble = true,
      nvimtree = {
        enabled = true,
      },
      telescope = true,
    },
  },
  -- Color Overrides
  {
    bg = '#121212',
    bg_float = '#090909',
    bg_popup = '#090909',
    bg_sidebar = '#090909',
    bg_statusline = '#121212',
    white_br = '#ffffff',
    diff = {
      add = colors.green,
      delete = colors.red,
      change = colors.yellow,
    }
  }
)

catppuccino.load()

-- Highlight yanked regions
vim.api.nvim_exec(
  [[
    augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
    augroup END
  ]],
  false
)
